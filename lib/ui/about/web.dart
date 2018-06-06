
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Web extends StatelessWidget {

  final String _title;
  final String _url;

  Web(this._title, this._url);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: this._url,
      appBar: new AppBar(
        title: new Text(_title),
        centerTitle: true,
      )
    );
  }

}