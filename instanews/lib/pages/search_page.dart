import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'webview.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Post> searchedPosts = List();
  bool isLoaded = false, hasNotSearched = true, isSearchSuccessful = true;
  String searchTerm;

  TextEditingController textEditingController = TextEditingController();

  String url = "http://newsapi.org/v2/everything?apiKey=33b24be8d9404eef8fed1bee30c73f2f&q=";

  handleSubmit(String term) async {
    setState(() {
      this.hasNotSearched = false;
      this.searchTerm = term;
    });

    try {
      final response = await http.get(url + searchTerm);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        searchedPosts = (data["articles"] as List).map((post) {
          return Post.fromJSON(post);
        }).toList();

        setState(() {
          this.isLoaded = true;
          if (searchedPosts.length == 0) {
            this.isSearchSuccessful = false;
          } else {
            this.isSearchSuccessful = true;
          }
        });
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blueAccent
        ),
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type here to search...'
          ),
          onSubmitted: handleSubmit,
        ),
        actions: <Widget>[
          this.hasNotSearched == false
            ? IconButton(
              icon: Icon(Icons.remove, color: Colors.red,),
              onPressed: () {
                setState(() {
                  textEditingController.text = "";
                  searchedPosts = List();
                  this.hasNotSearched = true;
                  this.isSearchSuccessful = true;
                });
              },
            )
            : SizedBox()
        ],
      ),
      body: hasNotSearched
        ? SizedBox()
        : isLoaded == false
        ? Center(child: CircularProgressIndicator(),)
        : isSearchSuccessful
        ? ListView.builder(
            itemCount: searchedPosts.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(searchedPosts[index].title),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => Webview(searchedPosts[index].url, searchedPosts[index].title)
                        )
                      );
                    },
                  ),
                  Divider()
                ],
              );
            }
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              Text("No results found",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),)
            ],
          ),
    );
  }
}