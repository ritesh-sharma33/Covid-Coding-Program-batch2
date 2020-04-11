
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:instanews/pages/home_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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
            SizedBox(height: deviceHeight * 0.21,),
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
            SizedBox(
              height: deviceHeight * 0.17,
            ),
            Text(
              "InstaNews",
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.blueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Always be Updated",
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