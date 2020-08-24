import 'package:flutter/material.dart';
import 'search_screen_body.dart';
class SearchResultGenerator extends StatelessWidget {
  String searchstring;
  SearchResultGenerator({this.searchstring});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
      ),
        body: Center(
          child: Text(
            searchstring,
          ),
        ),
    );


  }
 // List<conventionHall> list = [];
}
