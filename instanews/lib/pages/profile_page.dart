import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final String _fullName = "Ritesh Sharma";
  final _email = "sharmaritesh3312@gmail.com";
  final String _bio = "\"Hi, I am a freelance full stack developer working in a remote location. I am always free for collaborations.";
  final String _followers = "2307";
  final String _posts = "24";
  final String _scores = "4500";

  Widget _buildCoverImage(double deviceHeight) {
    return Container(
      height: deviceHeight / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/beach.jpg"), fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profile_pic.jpg"),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(color: Colors.white, width: 10.0)
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Raleway',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700
    );

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Text(
        _email,
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Raleway',
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w200
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54, fontSize: 24.0, fontWeight: FontWeight.bold
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        )
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(deviceHeight),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: deviceHeight / 6.25,),
                  _buildProfileImage(),
                  SizedBox(height: 5,),
                  _buildFullName(),
                  _buildEmail(context),
                  SizedBox(height: 5.0,),
                  _buildStatContainer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}