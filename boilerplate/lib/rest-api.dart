import 'package:boilerplate/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestApiDemo extends StatefulWidget {
  @override
  _RestApiDemoState createState() => _RestApiDemoState();
}

class _RestApiDemoState extends State<RestApiDemo> {

  List<User> users = List();

  String url = "https://reqres.in/api/users";
  bool isLoaded = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        users = (data["data"] as List).map((user) {
          return User.fromJSON(user);
        }).toList();

        setState(() {
          this.isLoaded = true;
        });

        print(users[0].email);

      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Rest API demo"),),
      body: isLoaded == true
        ? ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: deviceHeight * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(users[index].avatar),
                          fit: BoxFit.fill 
                        )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Name: " + users[index].firstName.toString() + users[index].lastName.toString()
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
        )
        : Center(
          child: CircularProgressIndicator(),
        ),
    );
  }
}