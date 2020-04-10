import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _fullName = "John Doe";
  final String _email = "johndoe@gmail.com";
  final String _phone = "1234567890";
  final String _bio =
      "\"Hi, I am a Freelance developer working at home at remote location and I am always free for collaboration...";
  final String _followers = "175";
  final String _posts = "24";
  final String _scores = "450";

  Widget _buildCoverImage(double deviceHeight) {
    return Container(
      height: deviceHeight / 2.6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/beach.jpg"), fit: BoxFit.cover)),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/profile_pic.jpg"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: Colors.white, width: 10.0)),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.w700);

    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.0)),
      child: Text(
        _email,
        style: TextStyle(
            fontFamily: 'Raleway',
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w200);

    TextStyle _statCountTextStyle = TextStyle(
        color: Colors.black54, fontSize: 24.0, fontWeight: FontWeight.bold);

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
      decoration: BoxDecoration(color: Color(0xFFEFF4F7)),
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

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(double deviceWidth) {
    return Container(
      width: deviceWidth / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8.0),
      child: Text("Get in touch with ${_fullName.split(" ")[0]},",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16.0,
          )),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    
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
                  SizedBox(height: 5.0,),
                  _buildBio(context),
                  _buildSeparator(deviceWidth),
                  SizedBox(height: 10.0,),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
