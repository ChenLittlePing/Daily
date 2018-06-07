import 'dart:async';

import 'package:daily/bean/tc_item.dart';
import 'package:daily/net/api_tc/tc_api.dart';
import 'package:daily/ui/about/about.dart';
import 'package:daily/ui/article/article_page.dart';
import 'package:daily/ui/photo/photo_ppt.dart';
import 'package:daily/ui/photo/photo_list.dart';
import 'package:daily/ui/speech/spech_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '每日图文',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  int count = 0;
  var items = Map<int, List<TCItem>>();
  String nextId;
  var curPage = 0;
  var scaffoldContext;

  @override
  void initState() {
    super.initState();

    _getNews(1, null);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 150.0,
              padding: EdgeInsets.fromLTRB(12.0, 32.0, 12.0, 12.0),
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                "每日图文",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(color: Colors.transparent),
            ListTile(
              title: Text("每日图片",
                  style: TextStyle(fontSize: 16.0, color: Colors.blue)),
              leading: Icon(Icons.picture_in_picture_alt, color: Colors.blue),
              onTap: _clickPicList,
            ),
            Divider(),
            ListTile(
              title: Text("每日文章", style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.chrome_reader_mode),
              onTap: _clickArticleList,
            ),
            Divider(),
            ListTile(
              title: Text("一席演讲", style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.speaker),
              onTap: _clickSpeechList,
            ),
            Divider(),
            ListTile(
              title: Text("关于", style: TextStyle(fontSize: 16.0)),
              leading: Icon(Icons.account_balance),
              onTap: _clickAbout,
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text("热门图片"),
        centerTitle: true,
        elevation: Theme.of(context).platform == TargetPlatform.iOS? 0.0 : 4.0
      ),
      body: new RefreshIndicator(
        onRefresh: () {
          return _getNews(1, null);
        },
        child: new ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: count,
            itemBuilder: (context, index) {
              scaffoldContext = context;
              if (items.length > 0 && index >= items.length - 1) {
                // 自动加载更多
                _getNews(curPage, nextId);
              }
              return GestureDetector(
                  onTap: () {
                    _clickPic(index);
                  },
                  child: Hero(
                    tag: "tag-" + index.toString() + "-0",
                    child: Card(
                        margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0 , 4.0),
                        child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                new CachedNetworkImage(
                                  imageUrl: items[index][0].url,
                                  placeholder: Container(
                                    child: Image
                                        .asset("images/ic-pic-loading.png"),
                                  ),
                                  fit: BoxFit.cover,
                                  errorWidget: new Icon(Icons.error),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: new BoxDecoration(
                                      color: Colors.black45,
                                    ),
                                    child: Center(
                                      child: Text(
                                        items[index][0].title.length != 0
                                            ? items[index][0].title
                                            : items[index][0].content,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ],
                            ))),
                  ));
            }),
      ),
    );
  }

  Future<Null> _getNews(page, postId) async {
    if (page > 1 && postId == null) return null;
    this.curPage = page;
    TCApi().getNew(page, postId, _getNewSuccess, _getNewFail);
    return null;
  }

  void _getNewSuccess(data) {
    if (curPage == 1) {
      setState(() {
        this.items.clear();
        this.count = 0;
        this.nextId = null;
      });
    }
    var map = Map<int, List<TCItem>>();
    int count = this.count;
    curPage++;
    for (var d in data["feedList"]) {
      if (d != []) {
        var items = <TCItem>[];
        for (var img in d["images"]) {
          if (img != null) {
            String url = "https://photo.tuchong.com/" +
                d["author_id"].toString() +
                "/f/" +
                img["img_id"].toString() +
                ".jpg";

            items.add(TCItem(d["title"], d["content"], url));
          }
        }
        if (items.length > 0) {
          map.putIfAbsent(count, () => items);
          count++;
        }
      }
    }

    setState(() {
      this.items.addAll(map);
      this.count = count;
      if (data["feedList"].length > 0) {
        var list = data["feedList"];
        this.nextId = list[list.length - 1]["post_id"].toString();
      }
    });
  }

  void _getNewFail(error, code) {
    if (scaffoldContext != null) {
      Scaffold
          .of(scaffoldContext)
          .showSnackBar(new SnackBar(content: new Text(error)));
    }
  }

  void _clickPic(index) {
    if (items[index].length > 1) {
      _navTo(PhotoList(items[index], index));
    } else {
      _navTo(new PhotoPPT(items[index], index, 0));
    }
  }

  void _clickPicList() {
    Navigator.pop(context);
  }

  void _clickArticleList() {
    Navigator.pop(context);
    _navTo(ArticlePage());
  }

  void _clickSpeechList() {
    Navigator.pop(context);
    _navTo(SpeechList());
  }

  void _clickAbout() {
    Navigator.pop(context);
    _navTo(About());
  }

  void _navTo(Widget widget) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
