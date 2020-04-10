import 'package:flutter/material.dart';
import 'package:instanews/pages/profile_page.dart';
import 'package:instanews/pages/splash_page.dart';
import './pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaNews',
      home: SplashPage(),
      routes: {
        '/myprofile': (context) => ProfilePage()
      },
    );
  }
}