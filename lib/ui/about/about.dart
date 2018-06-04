import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: Text("关于"), centerTitle: true),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: new Border.all(
                color: Colors.blue,
                width: 1.0,
              )),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Center(
                  child: Text("关于每日图文",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                ),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "《每日图文》是一个使用Google Flutter平台开发的跨平台App，可以在Android和iOS平台上运行。",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "Api来自：\nhttps://github.com/ChenLittlePing/-Api",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "使用组件：\nScaffold、Container、Center、ListView、GridView、PageView、Image、Text等等",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "使用框架：\n网络框架dio、图片显示缓存框架cached_network_image、日期格式化工具intl",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
                    child: Text("侵权请联系删除，谢谢！",
                        style: TextStyle(
                            fontSize: 15.0,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.blue)))
              ])),
        )));
  }
}
