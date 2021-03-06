import 'package:flutter/material.dart';
import 'package:instanews/pages/profile_page.dart';
import 'package:instanews/pages/saved_news_page.dart';
import 'package:instanews/pages/sources_page.dart';
import 'package:instanews/pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaNews',
      home: SplashScreen(),
      routes: {
        '/sources': (context) => SourcesPage(),
        '/profile': (context) => ProfilePage(),
        '/savedNews': (context) => SavedNewsPage()
      },
    );
  }
}