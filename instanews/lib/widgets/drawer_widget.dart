import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _buildDrawerHeader() {
      return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/beach.jpg'))),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 15,
              bottom: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/profile.png"))),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "johndoe@gmail.com",
                    style:
                        TextStyle(fontSize: 14, color: Colors.white, height: 1),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    _buildListTile(String title, Icon icon, String route) {
      return ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        onTap: () {
          if (route != '') {
            Navigator.pushNamed(context, route);
          }
        },
      );
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildDrawerHeader(),
          SizedBox(
            height: 10.0,
          ),
          _buildListTile("My Profile", Icon(Icons.perm_identity, color: Colors.blueAccent,), '/profile'),
          SizedBox(height: 5.0,),
          _buildListTile("Saved News", Icon(Icons.bookmark_border, color: Colors.blueAccent,), ''),
          SizedBox(height: 5.0,),
          _buildListTile("Settings", Icon(Icons.settings, color: Colors.blueAccent,), ''),
          SizedBox(height: 5.0,),
          _buildListTile("Sources", Icon(Icons.info_outline, color: Colors.blueAccent,), '/sources'),
          SizedBox(height: 5.0,),
          _buildListTile("Help Centre", Icon(Icons.help, color: Colors.blueAccent,), ''),
          SizedBox(height: 5.0,),
          _buildListTile("Contact Us", Icon(Icons.contacts, color: Colors.blueAccent,), ''),
          SizedBox(height: 5.0,),
          _buildListTile("About Us", Icon(Icons.info, color: Colors.blueAccent,), ''),
          SizedBox(height: 5.0,),
        ],
      ),
    );
  }
}
