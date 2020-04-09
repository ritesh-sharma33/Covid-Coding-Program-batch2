import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:instanews/models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url = "http://newsapi.org/v2/top-headlines?apiKey=33b24be8d9404eef8fed1bee30c73f2f&country=in";
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
    } catch(e) {
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
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
    );
  }

  _buildCardSubtitle(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600, color: Colors.black45, fontSize: 15),
    );
  }

  _buildNewsCard(Post post) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(post.image),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: _buildCardTitle(post.title),
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
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  post.author,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue[800]
                  ),
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
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InstaNews"),
        centerTitle: true,
      ),
      body: isLoaded == true
        ? ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return _buildNewsCard(posts[index]);
            }
          )
        : Center(child: CircularProgressIndicator(),)
    );
  }
}
