import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Webview extends StatelessWidget {

  String url, title;
  Webview(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebviewScaffold(
        url: this.url,
        appBar: AppBar(
          title: Text(this.title),
        ),
      ),
    );
  }
}