import 'package:flutter/material.dart';

///自动切换Android/iOS风格的标题栏布局
class AutoScaffold extends Scaffold {
  AutoScaffold({@required BuildContext context, needAppBar = true, String title, Widget body, color})
      : super(
      backgroundColor: color,
            appBar: needAppBar? AppBar(
                title: Text(title?? ""),
                centerTitle: true,
                elevation: Theme.of(context).platform == TargetPlatform.iOS
                    ? 0.0 : 4.0) : null,
            body: body);
}
