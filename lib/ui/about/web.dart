
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Web extends StatelessWidget {

  String url;

  Web(this.url);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: this.url,
      appBar: new AppBar(
        title: new Text("相关API"),
        centerTitle: true,
      )
    );
  }

}