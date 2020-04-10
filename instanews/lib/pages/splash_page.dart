import 'package:flutter/material.dart';

import 'home_page.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  startSplashTimer() {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigateToHome);
  }

  navigateToHome() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomePage()
      )
    );
  }

  @override
  void initState() { 
    startSplashTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.21),
            Container(
              height: 275,
              width: 275,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/news.gif")
                )
              ),
            ),
            SizedBox(height: deviceHeight * 0.17,),
            Text(
              "InstaNews",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),
            Text(
              "Always Updated",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.black,
                height: 1.1,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w600,
                wordSpacing: 1.5,
                fontSize: 22
              ),
            )
          ],
        ),
      ),
    );
  }
}