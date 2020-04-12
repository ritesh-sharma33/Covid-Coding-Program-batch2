import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SavedNewsPage extends StatefulWidget {
  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  List<Post> savedPosts = List();
  bool isLoaded = false;
  bool isDbPresent = true;

  Future<List<Post>> posts() async {
    final Future<Database> database =
        openDatabase(p.join(await getDatabasesPath(), 'instanews.db'),
            onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE news(id TEXT, title TEXT, description TEXT, image TEXT, author TEXT, name TEXT, url TEXT, publisedAt TEXT)");
    }, version: 1);

    final Database db = await database;

    try {
      final List<Map<String, dynamic>> maps = await db.query("news");
      return List.generate(maps.length, (i) {
        return Post(
            id: maps[i]["id"],
            title: maps[i]['title'],
            author: maps[i]['author'],
            image: maps[i]['image'],
            name: maps[i]['name'],
            url: maps[i]['url'],
            publishedAt: maps[i]['publishedAt']);
      });
    } catch (e) {
      print(e);
      setState(() {
        this.isDbPresent = false;
      });
    }
  }

  setSavedPosts() async {
    savedPosts = await posts();
    setState(() {
      this.isLoaded = true;
    });
  }

  @override
  void initState() {
    setSavedPosts();
    super.initState();
  }

  Widget _buildSavedNewsCard(Post post) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            post.image != null
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(post.image))),
                      ),
                      Container(
                        height: deviceHeight * 0.3,
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
                                  3
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
                                style: TextStyle(
                                    height: 1.25,
                                    fontSize: deviceHeight * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Raleway'),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                    child: Text(
                      post.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceHeight * 0.03,
                          color: Colors.black,
                          fontFamily: 'Raleway'),
                    ),
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
          title: Text(
            "Saved News",
            style: TextStyle(fontFamily: 'Raleway'),
          ),
        ),
        body: isDbPresent
            ? isLoaded
                ? ListView.builder(
                    itemCount: savedPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildSavedNewsCard(savedPosts[index]);
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : Center(
                child: Text("No saved news..."),
              ));
  }
}
