import 'package:flutter/material.dart';
import 'search_screen_top.dart';
class SearchResultGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
      ),
        body: Center(
          child: Text(
            SearchScreenTop.searchstring,
          ),
        ),
    );


  }
}
