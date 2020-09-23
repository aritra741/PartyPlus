import 'package:flutter/material.dart';
import 'package:partyplus/screens/map_view.dart';
import 'package:partyplus/screens/searchresultgenerator.dart';

class SearchResultListMap extends StatefulWidget {
  @override
  _SearchResultListMapState createState() => _SearchResultListMapState();
}

class _SearchResultListMapState extends State<SearchResultListMap> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller= new TabController(vsync: this, length: 2);
  }

  @override
  void dispose()
  {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: "ListView",
                icon: Icon(Icons.card_travel)),
            Tab(text:"MapView",
                icon: Icon(Icons.map))
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          SearchResultGenerator(searchstring: "sylhet"),
          MapView()
        ],
      ),
    );
  }
}
