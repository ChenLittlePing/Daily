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
  var _items = <SpeechIntro>[];

  var _page = 1;
  var _max = 2;

  var player = new APlayer();

  var playingIndex = -1;

  @override
  void initState() {
    super.initState();

    _getSpeeches(1);
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
                      Stack(alignment: Alignment.center, children: <Widget>[
                        Container(
                          foregroundDecoration:
                              BoxDecoration(color: Colors.black45),
                          child: CachedNetworkImage(
                              imageUrl: item.picUrl,
                              fit: BoxFit.cover,
                              errorWidget: new Icon(Icons.error)),
                        ),
                        Image.asset(playingIndex == index
                            ? (item.playing ? "images/ic-playing.png" : "images/ic-pause.png")
                            : "images/ic-play.png"),
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
      player.play(item.audioUrl).then((result) {
        if (result) {
          setState(() {
            if (playingIndex > -1) {
              var it = _items[playingIndex];
              it.playing = false;
            }
            playingIndex = index;
            item.playing = true;
          });
        }
      });
    } else {
      player.pause().then((result) {
        if (result) {
          setState(() {
            item.playing = false;
          });
        }
      });
    }
  }
}
