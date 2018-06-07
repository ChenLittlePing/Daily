import 'package:flutter/material.dart';

class AutoScaffold extends Scaffold {
  AutoScaffold({BuildContext context, String title, Widget body})
      : super(
            appBar: AppBar(
                title: Text(title),
                centerTitle: true,
                elevation: Theme.of(context).platform == TargetPlatform.iOS
                    ? 0.0 : 4.0),
            body: body);
}
