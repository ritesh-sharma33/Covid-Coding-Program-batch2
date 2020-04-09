import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:boilerplate/rest-api.dart';
import 'package:boilerplate/second_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boilerplate App',
      home: MyHomePage(),
      routes: {'/second': (context) => SecondScreen()},
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<AudioPlayer> playSound() async {
    AudioCache cache = new AudioCache();
    return await cache.play("sounds/facebook_sound.mp3");
  }

  @override
  Widget build(BuildContext context) {
    _buildTextWidget(String text) {
      return Text(text, style: headerTextStyle);
    }

    _buildCard() {
      return Card(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.phone_iphone,
              color: Colors.black,
              size: 100,
            ),
            Text(
              "This is a dummy iPhone",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Boilerplate App"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _buildTextWidget("Hello and welcome here..."),
            SizedBox(
              height: 20,
            ),
            _buildCard(),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("Click me to see the magic", style: buttonTextStyle),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SecondScreen()
                //   )
                // )

                // Navigator.pushNamed(context, '/second');

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SecondScreen()
                //   )
                // );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestApiDemo()
                  )
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/setup.jpg",
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
