
import 'package:flutter/material.dart';
import 'package:instanews/pages/webview.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Post> searchResults = List();
  bool isLoaded = false, hasNotSearched = true, isSearchSuccessful = true;
  String searchTerm;

  String url = "https://newsapi.org/v2/everything?apiKey=33b24be8d9404eef8fed1bee30c73f2f&q=";

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  handleSubmit(String term) async {
    setState(() {
      hasNotSearched = false;
      searchTerm = term;
    });

    try {
      final response = await http.get(url + searchTerm);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        searchResults = (data["articles"] as List).map((post) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        title: TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type here to search...'
          ),
          onSubmitted: handleSubmit,
        ),
        actions: <Widget>[
          hasNotSearched == false
            ? IconButton(
              icon: Icon(Icons.remove_circle_outline, color: Colors.red,),
              onPressed: () {
                setState(() {
                  textEditingController.text = "";
                  searchResults = List();
                  hasNotSearched = true;
                });
              },
            ) : SizedBox()
        ],
      ),

      body: hasNotSearched
        ? SizedBox()
        : isLoaded == false
        ? Center(child: CircularProgressIndicator(),)
        : isSearchSuccessful
        ? ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(searchResults[index].title),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => Webview(searchResults[index].url, searchResults[index].title)
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