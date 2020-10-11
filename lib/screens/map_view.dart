import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:partyplus/screens/searchresultgenerator.dart';

class MapView extends StatefulWidget {
  String searchString;
  List<Marker>locations= <Marker>[];
  List<double>latlist, longlist;
  List<String>nameList;
  GoogleMapController mapController;

  MapView({this.searchString});

  @override
  _MapViewState createState() => _MapViewState(searchString: searchString);
}

class _MapViewState extends State<MapView> {

  String searchString;
  List<Marker>locations= <Marker>[];
  List<conventionHall>hallList= new List();
  List<double>latlist, longlist;
  List<String>nameList;
  _MapViewState({this.searchString});
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List<conventionHall>> postData() async{

    var match = {
      "what" : searchString
    };
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/search";
    //http.Response response = await http.post(apiurl);
    /* final response = await http.post(apiurl,body: {
      "name" : searchstring
    });*/
    http.Response response;
    try{
      response= await http.post(apiurl,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: match,
          encoding: Encoding.getByName("utf-8"));
    }catch(e) {
      print(e.toString());
    };

    //print("HYSE??");
    // body: json.encode(match),);
    //  data = json.decode(response.body);
    //  debugPrint(fuserData.toString());
    //  setState(() {
    //    fuserData = data['Name'];
    //  });
    //  debugPrint(fuserData.toString());

    hallList.clear();

    var jsonlist = jsonDecode(response.body) as List;
    jsonlist.forEach((e) {
      hallList.add(conventionHall.fromJson(e));
      // list.add(conventionHall.fromJson(e));
    });

    return hallList;
  }

  @override
  void initState() {

    super.initState();

    hallList.clear();
    hallList= SearchResultGenerator.globalHallList;

    latlist= new List();
    longlist= new List();
    nameList= new List();

    for( int i=0;i<hallList.length;i++ )
    {
      print('lat holo'+hallList[i].Name);
      latlist.add( hallList[i].Lat );
      longlist.add( hallList[i].Long );
      nameList.add( hallList[i].Name );
    }

    for( int i=0;i<latlist.length;i++ )
    {
      setState(() {
        locations.add(
            Marker(
                markerId: MarkerId((i+1).toString()),
                position: LatLng(latlist[i],longlist[i]),
                infoWindow: InfoWindow(
                    title: nameList[i]
                )
            )
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    print(searchString);
    var val;

    for( val in locations )
      print(val);

    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: latlist.length>0?LatLng(latlist[0],longlist[0]):LatLng(24.887635,91.874310),
            zoom: 9.0,
          ),
          mapType: MapType.normal,
          markers: Set<Marker>.of(locations),
          onMapCreated: _onMapCreated
      ),
    );
  }
}
