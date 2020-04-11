import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instanews/models/source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'webview.dart';

class SourcesPage extends StatefulWidget {
  @override
  _SourcesPageState createState() => _SourcesPageState();
}

class _SourcesPageState extends State<SourcesPage> {

  String url = "http://newsapi.org/v2/sources?apiKey=33b24be8d9404eef8fed1bee30c73f2f";
  bool isLoaded = false;
  List<Source> sources = List();

  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        sources = (data['sources'] as List).map((data) {
          return Source.fromJSON(data);
        }).toList();
        setState(() {
          this.isLoaded = true;
        });
        print(sources[0].name);
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

  @override
  Widget build(BuildContext context) {

    _generateRandomNumber(int min, int max) {
      Random random = new Random();
      int r = min + random.nextInt(max - min);
      return r;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        title: Text('News Sources', style: TextStyle(color: Colors.blueAccent, fontFamily: 'Raleway', fontWeight: FontWeight.w600, fontSize: 23),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),          
          itemCount: sources.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => Webview(sources[index].url, sources[index].name)
                  )
                );
              },
              child: new Card(
                child: GridTile(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/sources/${_generateRandomNumber(1, 6)}.jpeg"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            sources[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            sources[index].country.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}