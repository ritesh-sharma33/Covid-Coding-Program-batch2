import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instanews/models/post.dart';
import 'package:instanews/pages/webview.dart';
import 'package:instanews/widgets/drawer_widget.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "http://newsapi.org/v2/top-headlines?apiKey=33b24be8d9404eef8fed1bee30c73f2f&country=in";
  bool isLoaded = false;

  List<Post> posts = List();

  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        posts = (data["articles"] as List).map((post) {
          return Post.fromJSON(post);
        }).toList();

        setState(() {
          this.isLoaded = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  _buildCardTitle(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    );
  }

  _buildCardSubtitle(String text) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black45,
          fontSize: 15,
          fontFamily: 'Raleway'),
    );
  }

  Future _saveNews(Post post) async {
    final Future<Database> database =
        openDatabase(p.join(await getDatabasesPath(), 'instanews.db'),
            onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE news(id TEXT, title TEXT, description TEXT, image TEXT, author TEXT, name TEXT, url TEXT, publishedAt TEXT)");
    }, version: 1);

    final Database db = await database;
    return db.insert('news', Post.toMap(post));
  }

  _buildNewsCard(Post post) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Webview(post.url, post.title)));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            post.image != ''
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(post.image))),
                      ),
                      Container(
                        height: deviceHeight * 0.35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.center,
                                colors: [
                                  Colors.black.withOpacity(0.55),
                                  Colors.black.withOpacity(0.15)
                                ],
                                stops: [
                                  0.5,
                                  1
                                ])),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.125,
                                  left: 8.0,
                                  right: 8.0),
                              child: Text(
                                post.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    height: 1.25,
                                    fontSize: deviceHeight * 0.031,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Raleway'),
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, top: 5),
              child: _buildCardSubtitle(post.description),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    post.publishedAt.toString(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontFamily: 'Raleway'),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    post.author,
                    style: TextStyle(fontSize: 15, color: Colors.blue[800]),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.bookmark_border),
                  onPressed: () {
                    _saveNews(post);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: new Text("Success"),
                            content: new Text("Post Saved Successfully..."),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"))
                            ],
                          );
                        });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(
                        "Read this latest news from InstaNews: \n${post.title}.\n ${post.url}");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => SearchPage()
                  )
                );
              },
            )
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
          title: Text(
            "InstaNews",
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.blueAccent),
          ),
          centerTitle: true,
        ),
        drawer: DrawerWidget(),
        body: isLoaded == true
            ? RefreshIndicator(
                child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return _buildNewsCard(posts[index]);
                    }),
                onRefresh: _fetchData,
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
