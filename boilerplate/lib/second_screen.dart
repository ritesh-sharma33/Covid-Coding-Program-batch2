
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Text("Launch Google"),
            onPressed: _launchURL
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = "https://google.com";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Could not launch $url";
  }
}