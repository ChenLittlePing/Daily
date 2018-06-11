import 'package:daily/widget/auto_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class SpeechArticle extends StatefulWidget {
  final String _title;
  final String _author;
  final String _article;

  SpeechArticle(this._title, this._author, this._article);

  @override
  State<StatefulWidget> createState() {
    return _SpeechArticleState();
  }
}

class _SpeechArticleState extends State<SpeechArticle> {
  @override
  Widget build(BuildContext context) {
    return new AutoScaffold(
        context: context,
        title: widget._title,
        needAppBar: false,
        color: Colors.white,
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Container(
                    margin: EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 24.0),
                    child: Text(widget._title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            height: 2.0,
                            fontSize: 24.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)));
              } else if (i == 1) {
                return Container(
                    margin: EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 24.0),
                    child: Text("文 / " + widget._author,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)));
              }
              return Container(
                  margin: EdgeInsets.all(8.0),
                  child: new HtmlView(data: widget._article));
            }));
  }
}
