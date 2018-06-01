import 'package:daily/bean/article.dart';
import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget {
  Article article;

  ArticleDetail(this.article);

  @override
  State<StatefulWidget> createState() {
    return ArticleDetailState();
  }
}

class ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.article.title),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(widget.article.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2.0,
                            fontSize: 18.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold)));
              } else if (i == 1) {
                return Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text("文/" + widget.article.author,
                        style: TextStyle(
                            height: 1.2,
                            fontSize: 16.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)));
              }
              return Container(
                  margin: EdgeInsets.all(8.0),
                  child:
                      RichText(text: new TextSpan(children: _getParagraph())));
            }));
  }

  _getParagraph() {
    var pgps = widget.article.content.split("</p>");
    var texts = <TextSpan>[];
    for (var text in pgps) {
      texts.add(TextSpan(
          text: texts.length == 0
              ? text.replaceAll("<p>", "")
              : text.replaceAll("<p>", "\n\n"),
          style: TextStyle(
              height: 1.2,
              fontSize: 16.0,
              letterSpacing: 1.2,
              wordSpacing: 1.2,
              color: Colors.black54)));
    }
    return texts;
  }
}
