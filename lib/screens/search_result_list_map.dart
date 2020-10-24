import 'package:flutter/material.dart';
import 'package:partyplus/screens/map_view.dart';
import 'package:partyplus/screens/searchresultgenerator.dart';

class SearchResultListMap extends StatefulWidget {
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  SearchResultListMap({this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift});
  @override
  _SearchResultListMapState createState() => _SearchResultListMapState(searchstring,dayString,selectedDate,secDate,thDate,dayOneShift, dayTwoShift, dayThreeShift);
}

class _SearchResultListMapState extends State<SearchResultListMap> with SingleTickerProviderStateMixin {

  TabController controller;
  bool type= false;
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  _SearchResultListMapState(this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller= new TabController(vsync: this, length: 2);
    controller.addListener(handleTabSwipe);
}

  void handleTabSwipe()
  {
    setState(() {
      type= true;
    });
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
        backgroundColor: Color(0xFF005e6a),
        bottom: TabBar(
          onTap: (e){
            setState((){
              type= true;
            });
          },
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
          SearchResultGenerator(searchstring: searchstring,dayString:dayString,selectedDate:selectedDate,secDate:secDate,thDate:thDate,dayOneShift:dayOneShift,dayTwoShift: dayTwoShift, dayThreeShift: dayThreeShift, type: type),
          MapView(searchString: searchstring)
        ],
      ),
    );
  }
}
