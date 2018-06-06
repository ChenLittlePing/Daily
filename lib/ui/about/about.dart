import 'package:daily/ui/about/web.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text("关于"),
            centerTitle: true,
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
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
                GestureDetector(
                    onTap: () {
                      _navToWeb(context, "项目地址",
                          "https://github.com/ChenLittlePing/Daily");
                    },
                    child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "项目地址(喜欢就给个Star吧😊)：\n",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  height: 1.5,
                                  color: Colors.black87,
                                  letterSpacing: 1.2)),
                          TextSpan(
                              text: "https://github.com/ChenLittlePing/Daily",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  height: 1.5,
                                  letterSpacing: 1.2,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))
                        ])))),
                Divider(
                  color: Colors.blue,
                ),
                GestureDetector(
                    onTap: () {
                      _navToWeb(context, "相关API",
                          "https://github.com/ChenLittlePing/-Api");
                    },
                    child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Api来自：\n",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  height: 1.5,
                                  color: Colors.black87,
                                  letterSpacing: 1.2)),
                          TextSpan(
                              text: "https://github.com/ChenLittlePing/-Api",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  height: 1.5,
                                  letterSpacing: 1.2,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline))
                        ])))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "使用组件：\nScaffold、Container、Center、ListView、"
                        "GridView、PageView、Image、Text、RichText等等",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                        "使用框架：\n- 网络框架dio\n- 图片显示缓存框架cached_network_image\n"
                        "- 日期格式化工具int\n- WebView插件flutter_webview_plugin",
                        style: TextStyle(
                            fontSize: 15.0, height: 1.5, letterSpacing: 1.2))),
                Divider(
                  color: Colors.blue,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 24.0),
                    child: Text("仅供学习，禁止商用\n侵权请联系删除，谢谢!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Colors.blue)))
              ])),
        )));
  }

  _navToWeb(context, String title, String url) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Web(title, url);
    }));
  }
}
