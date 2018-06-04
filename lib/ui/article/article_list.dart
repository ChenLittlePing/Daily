import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily/bean/article.dart';
import 'package:daily/net/api_article/article_api.dart';
import 'package:daily/ui/article/article_detail.dart';
import 'package:flutter/material.dart';

class ArticleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticleListState();
  }
}

class ArticleListState extends State<ArticleList> {
  var myContext;
  var _items = <Article>[];

  @override
  void initState() {
    super.initState();
    _getListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("每日文章"),
          centerTitle: true,
        ),
        body: new Builder(builder: (BuildContext context) {
          myContext = context;
          return ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: _navToDetail,
                  child: Card(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset("images/ic-pic-article.gif",
                              width: 150.0, height: 150.0),
                          Divider(),
                          Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.all(8.0),
                                    child: Text(_items[i].title,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            letterSpacing: 1.0)),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(8.0),
                                      child: Text(_items[i].digest,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                              letterSpacing: 1.0),
                                          maxLines: 2))
                                ],
                              ))
                        ],
                      )),
                );
              });
        }));
  }

  void _getListData() {
    ArticleApi().getArticle(null, (data) {
      var d = data["data"];
      var item = Article(d["title"], d["author"], d["digest"], d["content"]);
      setState(() {
        _items.add(item);
      });
    }, (error) {
      Scaffold.of(myContext).showSnackBar(
          new SnackBar(content: new Text(error)));
    });
  }

  void _navToDetail() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetail(_items[0]);
    }));
  }
}
