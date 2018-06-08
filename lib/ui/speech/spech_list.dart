import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/speech_intro.dart';
import 'package:daily/net/api_yx/yx_api.dart';
import 'package:daily/utils/media/audio/audio_player.dart';
import 'package:daily/widget/auto_scaffold.dart';
import 'package:flutter/material.dart';

class SpeechList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpeechListState();
}

class _SpeechListState extends State<SpeechList> {
  static var _items = <SpeechIntro>[];

  var _page = 1;
  var _max = 2;

  var _player = new APlayer();

  static var _playingIndex = -1;

  Duration _duration = Duration(), _position = Duration();

  Timer _seekTimer;

  @override
  void initState() {
    super.initState();
    _initPlayer();
    if (_items.length == 0) {
      _getSpeeches(1);
    }
  }

  _initPlayer() {
    _player.setDurationHandler(_handlerDuration);
    _player.setPositionHandler(_handlerPosition);
    _player.setCompletionHandler(_handlerCompletion);
    _duration = _player.getDuration();
    _position = _player.getPosition();
  }

  @override
  Widget build(BuildContext context) {
    return new AutoScaffold(
      context: context,
      title: "精彩演讲",
      body: new RefreshIndicator(
        onRefresh: () {
          return _getSpeeches(1);
        },
        child: new ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            if (index >= (_items.length - 1) && _page < _max) {
              _getSpeeches(_page + 1);
            }
            var item = _items[index];
            return GestureDetector(
              onTap: () {
                _clickItem(item, index);
              },
              child: Card(
                  margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(alignment: Alignment.bottomCenter, children: <
                          Widget>[
                        Stack(alignment: Alignment.center, children: <Widget>[
                          Container(
                            foregroundDecoration:
                                BoxDecoration(color: Colors.black45),
                            child: CachedNetworkImage(
                                imageUrl: item.picUrl,
                                fit: BoxFit.cover,
                                errorWidget: new Icon(Icons.error)),
                          ),
                          Image.asset(_playingIndex == index
                              ? (item.playing
                                  ? "images/ic-playing.png"
                                  : "images/ic-pause.png")
                              : "images/ic-play.png"),
                        ]),
                        Container(
                            color: Colors.black54,
                            alignment: Alignment.center,
                            child: Offstage(
                                offstage: _playingIndex != index,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 65.0,
                                        child: Text(
                                            _sec2hms(_position.inSeconds),
                                            style: TextStyle(
                                                color: Colors.white))),
                                    SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                            activeTrackColor: Colors.lightBlue,
                                            inactiveTrackColor: Colors.white,
                                            thumbColor: Colors.lightBlue,
                                            overlayColor: Colors.white,
                                            valueIndicatorColor: Colors.white,
                                            valueIndicatorTextStyle:
                                                TextStyle(color: Colors.black)),
                                        child: Slider(
                                          onChanged: (value) {
                                            _delaySeek(value);
                                          },
                                          value: _position.inSeconds.toDouble(),
                                          label: _sec2hms(_position.inSeconds),
                                          min: 0.0,
                                          max: _duration.inSeconds.toDouble(),
                                          divisions: _duration.inSeconds > 0
                                              ? _duration.inSeconds
                                              : 1,
                                        )),
                                    Container(
                                        width: 65.0,
                                        child: Text(
                                            _sec2hms(_duration.inSeconds),
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                )))
                      ]),
                      Container(
                        margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Text(item.speaker.name,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black87)),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
                          child: Text(
                            item.title,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.all(8.0),
                          child: Text(item.content,
                              style: TextStyle(
                                  fontSize: 14.0, letterSpacing: 1.2)))
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  Future<Null> _getSpeeches(int page) async {
    new YxApi().getSpeeches(page, (data) {
      _page = data["data"]["page"];
      _max = data["data"]["pageSize"];
      _formatData(data["data"]["speechs"]);
    }, (error, code) {});
    return null;
  }

  _formatData(speeches) {
    var items = <SpeechIntro>[];
    for (var speech in speeches) {
      var speak = speech["speaker"];
      var speaker = Speaker(speak["type_speaker"], speak["intro"],
          speak["avatar"], speak["name"]);
      var intro = SpeechIntro(
          speech["id"],
          speech["title"],
          speech["video_cover"],
          speech["audio"],
          speech["titlelanguage"],
          speaker);

      items.add(intro);
    }

    setState(() {
      if (_page == 1) _items.clear();
      _items.addAll(items);
    });
  }

  _clickItem(SpeechIntro item, index) {
    if (!item.playing) {
      _player.play(item.audioUrl).then((result) {
        if (result) {
          setState(() {
            if (_playingIndex > -1) {
              var it = _items[_playingIndex];
              it.playing = false;
            }
            _playingIndex = index;
            item.playing = true;
          });
        }
      });
    } else {
      _player.pause().then((result) {
        if (result) {
          setState(() {
            item.playing = false;
          });
        }
      });
    }
  }

  void _handlerDuration(Duration duration) {
    setState(() {
      _duration = duration;
    });
  }

  void _handlerPosition(Duration duration) {
    setState(() {
      if (_seekTimer != null && _seekTimer.isActive) return;
      _position = duration;
    });
  }

  void _handlerCompletion() {
    setState(() {
      _items[_playingIndex].playing = false;
      _playingIndex = -1;
    });
  }

  String _sec2hms(int second) {
    int hour = second ~/ 3600;
    int min = (second - hour * 3600) ~/ 60;
    int sec = second - hour * 3600 - min * 60;

    String time = hour < 10 ? "0" + hour.toString() : hour.toString();
    time += ":" + (min < 10 ? "0" + min.toString() : min.toString());
    time += ":" + (sec < 10 ? "0" + sec.toString() : sec.toString());

    return time;
  }

  void _delaySeek(double seconds) {
    setState(() {
      _position = Duration(seconds: seconds.toInt());
    });
    if (_seekTimer == null) {
      _starSeekTimer(seconds);
    } else {
      _seekTimer.cancel();
      _starSeekTimer(seconds);
    }
  }

  void _starSeekTimer(double seconds) {
    _seekTimer = Timer(Duration(seconds: 1),
            () {
          _player.seek(seconds);
        });
  }
}
