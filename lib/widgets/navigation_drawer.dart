import 'package:flutter/material.dart';
import 'package:partyplus/screens/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class NavigationDrawer extends StatelessWidget {

  Future<void> clean () async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 150,
            //width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/logo.jpg'),
                  width: 300,
                  fit:BoxFit.fill ,
                ),
                /*Text(
                  "Party",
                  style: GoogleFonts.overpass(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w200 ),
                ),
                Text(
                  "Plus",
                  style: GoogleFonts.overpass(color: Color(0xFF008A8C), fontSize: 32, fontWeight: FontWeight.bold ),
                )*/
              ],
            ),
          ),
          Divider(color: Colors.black),
          if(SearchScreenBody.authenticatedUser!=null)
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
          if(SearchScreenBody.authenticatedUser!=null)
          ListTile(
          onTap: () {
            clean();
            SearchScreenBody.authenticatedUser = null;
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreenBody()));
          },
            leading: Icon(Icons.arrow_back),
            title: Text("Logout", style: TextStyle(fontSize: 18),),
          ),

        ],
      ),
    );
  }
}
