import 'package:flutter/material.dart';
import 'package:partyplus/screens/user_profile.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            color: Color(0xFF004b55),
          ),
          ListTile(
            onTap: ()=> Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfile())),
            leading: Icon(Icons.person),
            title: Text("Profile", style: TextStyle(fontSize: 18),),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings", style: TextStyle(fontSize: 18),),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Logout", style: TextStyle(fontSize: 18),),
          ),

        ],
      ),
    );
  }
}
