import 'package:flutter/material.dart';
import 'package:partyplus/screens/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Party",
                  style: GoogleFonts.overpass(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w200 ),
                ),
                Text(
                  "Plus",
                  style: GoogleFonts.overpass(color: Color(0xFF008A8C), fontSize: 32, fontWeight: FontWeight.bold ),
                )
              ],
            ),
          ),
          Divider(color: Colors.black),
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
