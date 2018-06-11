import 'dart:async';

import 'package:daily/bean/speech_intro.dart';
import 'package:daily/bean/video.dart';
import 'package:daily/net/api_yx/yx_api.dart';
import 'package:daily/ui/speech/speech_article.dart';
import 'package:daily/widget/auto_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:screen/screen.dart';

class SpeechVideo extends StatefulWidget {
  final SpeechIntro _intro;

  SpeechVideo(this._intro);

  @override
  State<StatefulWidget> createState() => SpeechVideoState();
}

class SpeechVideoState extends State<SpeechVideo> {
  VideoPlayerController _controller;

  Video _video;

  var _comments = <Comments>[];

  @override
  void initState() {
    super.initState();
    _getVideoDetail();
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    Screen.keepOn(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoScaffold(
      context: context,
      title: widget._intro.title,
      color: Colors.white,
      body: _video == null
          ? Container(child: Center(child: Text("正在加载...")))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Chewie(
                    _controller,
                    autoPlay: true,
                    looping: false,
                    placeholder: Container(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget._intro.title,
                            style: TextStyle(fontSize: 22.0, color: Colors.black)),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                          child: Text(
                              "#" +
                                  widget._intro.category +
                                  " / " +
                                  widget._intro.city +
                                  " / " +
                                  widget._intro.date,
                              style: TextStyle(
                                  fontSize: 14.5,
                                  color: Colors.black54,
                                  height: 1.5,
                                  letterSpacing: 1.2)),
                        ),
                        Text(widget._intro.content,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                                wordSpacing: 1.2)),
                        GestureDetector(
                          onTap: _navToArticle,
                          child: Text("查看完整演讲稿",
                              style: TextStyle(
                                  fontSize: 16.5,
                                  color: Colors.deepOrangeAccent,
                                  height: 1.5)),
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                              decoration: BoxDecoration(
                                  border: new Border.all(
                                    color: Colors.grey,
                                    width: 0.5,
                                  )),
                              child: Column(children: <Widget>[
                                Container(
                                  constraints: new BoxConstraints(minHeight: 40.0),
                                ),
                                Container(
                                    margin: EdgeInsets.all(20.0),
                                    child: Text(widget._intro.speaker.intro,
                                        style:
                                        TextStyle(height: 1.5, fontSize: 16.0)))
                              ]),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 10.0, color: Colors.white)),
                                  child: new ClipOval(
                                    child: new SizedBox(
                                      width: 60.0,
                                      height: 60.0,
                                      child: new Image.network(
                                        widget._intro.speaker.avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(widget._intro.speaker.name,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 15.0))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text("    热门评论", style: TextStyle(height: 2.0),),
                  Divider(),
                  Container(
                    margin: EdgeInsets.all(12.0),
                    child: ListBody(children: _getCommentViews())
                  )
                ],
              )),
    );
  }

  List<Widget> _getCommentViews() {
    var views = <Widget>[];
    for (var comment in _comments) {
      views.add(Row(
        children: <Widget>[
          new ClipOval(
            child: new SizedBox(
              width: 60.0,
              height: 60.0,
              child: new Image.network(
                comment.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 12.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(comment.nickname, style: TextStyle(height: 2.5)),
              Text(comment.content, style: TextStyle(height: 1.0, color: Colors.black54)),
              Text(comment.created, style: TextStyle(height: 2.0, color: Colors.black45))
            ],
          )),
          Container(
            width: 12.0,
          ),
        ],
      ));
      views.add(Divider());
    }
    return views;
  }

  Future<String> _getVideoDetail() async {
    new YxApi().getSpeechDetail(widget._intro.id, (data) {
      var speech = data["data"]["speech"];
      var video = speech["video"];
      var comments = data["data"]["hot_comments"];
      for (var comment in comments) {
        _comments.add(Comments(comment["content"], comment["nickname"],
            comment["created"], comment["avatar"]));
      }
      setState(() {
        _video = Video(
            video[0]["video_url"], video[1]["video_url"], widget._intro.cover, speech["draft"]);
        _controller = new VideoPlayerController.network(_video.sUrl);
        print(_video.sUrl);
      });
    }, (error, code) {});
    return null;
  }

  _navToArticle() {
    Navigator.push(context, new MaterialPageRoute(builder: (context){
      return new SpeechArticle(widget._intro.title, widget._intro.speaker.name, _video.draft);
    }));
  }
}
