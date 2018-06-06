import 'package:daily/bean/article.dart';
import 'package:daily/net/api_article/article_api.dart';
import 'package:daily/utils/date.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleState();
  }
}

class _ArticleState extends State<ArticlePage> {
  var _items = Map<String, Article>();
  var _myContext;
  String _title = "每日文章";

  @override
  void initState() {
    super.initState();
    _onViewChange(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          elevation: Theme.of(context).platform == TargetPlatform.iOS? 0.0 : 4.0
        ),
        body: Builder(builder: (BuildContext context) {
          _myContext = context;
          return PageView.builder(
              itemCount: 5 + _items.length,
              onPageChanged: _onViewChange,
              itemBuilder: (context, page) {
                if (_items.length <= page) {
                  return new Center(child: Text("正在加载..."));
                }

                Article item = _items[_getDate(page)];
                if (item.content == "暂未更新") {
                  return Center(child: Text("暂未更新"));
                }
                return new Container(
                    child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Container(
                                margin: EdgeInsets.all(8.0),
                                child: Text(item.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 2.0,
                                        fontSize: 18.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold)));
                          } else if (i == 1) {
                            return Container(
                                margin: EdgeInsets.all(8.0),
                                child: Text("文 / " + item.author,
                                    style: TextStyle(
                                        height: 1.2,
                                        fontSize: 16.0,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)));
                          }
                          return Container(
                              margin: EdgeInsets.all(8.0),
                              child: RichText(
                                  text: new TextSpan(
                                      children: _getParagraph(item))));
                        }));
              });
        }));
  }

  _onViewChange(int i) {
    String date = _getDate(i);
    setState(() {
      _title = date;
    });
    if (_items[date] == null || !_items[date].success) {
      _getArticle(i);
    }
  }

  void _getArticle(int offset) {
    var date = _getDate(offset);

    ArticleApi().getArticle(date, (data) {
      var d = data["data"];
      var item = Article(d["title"], d["author"], d["digest"], d["content"]);
      setState(() {
        _items.putIfAbsent(d["date"]["curr"], () => item);
      });
    }, (error, code) {
      if (code == 404) {
        var item = Article("", "", "", "暂未更新", false);
        setState(() {
          _items.putIfAbsent(date, () => item);
        });
      } else {
        Scaffold
            .of(_myContext)
            .showSnackBar(new SnackBar(content: new Text(error)));
      }
    });
  }

  _getParagraph(Article article) {
    var pgps = article.content.split("</p>");
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

  _getDate(int offset) {
    return Date.getDate(offset, "yyyMMdd");
  }
}
