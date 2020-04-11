import 'package:flutter/material.dart';
import 'package:instanews/pages/profile_page.dart';
import 'package:instanews/pages/sources_page.dart';
import 'package:instanews/pages/splash_page.dart';
import './pages/home_page.dart';

import './pages/saved_news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InstaNews',
      home: SplashPage(),
      routes: {
        '/myprofile': (context) => ProfilePage(),
        '/sources': (context) => SourcesPage(),
        '/savedNews': (context) => SavedNewsPage()
      },
    );
  }
}