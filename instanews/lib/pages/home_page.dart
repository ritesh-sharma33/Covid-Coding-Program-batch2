import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  _buildNewsCard() {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset("assets/images/setup.jpg"),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: _buildCardTitle(
                "New PC setup done today at my workplace. It's an awesome experience"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 5),
            child: _buildCardSubtitle(
                "New PC with 32 gigs of RAM and 4 TB of storage. It took me around 36 hours to do so. "),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "7 Apr 2020",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "John Doe",
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
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(1),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return _buildNewsCard();
              },
            )),
      ),
    );
  }
}
