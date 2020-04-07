
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boilerplate App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boilerplate App"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              "Hello and welcome here...",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.phone_iphone,
                    color: Colors.black,
                    size: 100,
                  ),
                  Text(
                    "This is a dummy iPhone",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                "Click me to see the magic",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              onPressed: () {
                
              },
            ),
            SizedBox(height: 20,),
            Image.asset(
              "assets/images/setup.jpg",
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}