import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'ImageList.dart';

class conventionHallDetails extends StatefulWidget {
  int num_of_days=2;
  conventionHall convention ;
  conventionHallDetails({this.convention});
  @override
  _conventionHallDetailsState createState() => _conventionHallDetailsState(convention);
}

class _conventionHallDetailsState extends State<conventionHallDetails> {
  int num_of_days=2;
  conventionHall convention;

  _conventionHallDetailsState(this.convention);

  String str;

  GoogleMapController mapController;
  List<Marker>locations = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      str = convention.Name;
      locations.add(
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(24.887635, 91.874310),
              infoWindow: InfoWindow(
                  title: 'International Convention City'
              )
          )
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
      ),
      /*  body: Center(
        child: Text(
          convention.Name,
        ),
      ),*/

      body: Container(
        //padding: const EdgeInsets.all(8.0),
        child: Container(
          //color: Colors.black12,
         // height: 1500,
          decoration: BoxDecoration(
            color: Colors.black12,
          ),
          child: StaggeredGridView.count(
            crossAxisCount: 6,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            staggeredTiles: [
              StaggeredTile.count(3, 2),
              StaggeredTile.count(3, 2),

              StaggeredTile.count(2, 1.8),
              StaggeredTile.count(2, 1.8),
              StaggeredTile.count(2, 1.8),
              StaggeredTile.count(6, 7),

            ],

            children: <Widget>[
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2"),
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1"),
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51"),
              Stack(
                children: <Widget>[
                  myPhotoList(
                      "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),

                  Container(
                    child: new GestureDetector(
                        onTap: () {
                          //print("naam holo "+convention.Name);
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageList(convention: convention)));
                        },
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xCC000000),
                          const Color(0x00000000),
                          const Color(0x00000000),
                          const Color(0xCC000000),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: new GestureDetector(
                          onTap: () {
                            //print("naam holo "+convention.Name);
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageList(convention: convention)));
                          },
                          child : Text(
                            '5+',
                            style: TextStyle(color: Colors.white,
                              fontSize: 30.0,),


                          )
                      ),
                  ),
                ],
              ),
              Details(),
            ],


          ),
        ),


      ),
    );
  }

  Widget Details() {

    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(convention.Name,
                style: TextStyle(color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: 300,
                width: 400,
                child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(24.887635, 91.874310),
                      zoom: 11.0,
                    ),
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(locations),
                    onMapCreated: _onMapCreated
                )
            ),
          ),
          Row(
              children: <Widget>[
                //Text("Hi"),
                Icon(Icons.location_on),
                Text(convention.street + "," + convention.City,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ]
          ),
          Row(

              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 10.0),
                  child : Text("\nFacilities",
                      style: TextStyle(color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),


              ]
          ),
          AC(),
          WiFi(),
          CC(),
          PhotoShoots(),
          Parkinglot(),
          Row(

              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("\nMiscellanous",
                      style: TextStyle(color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),
              ]
          ),
         Structure(),
          FireWorks(),
          FireExting(),

          PriceDetails(1),
          AddRemoveButton(),
          PriceDetails(2),
          AddRemoveButton(),
          PriceDetails(3),
          AddRemoveButton(),
          TotalPrice(),
        ],
      ),
    );
  }

  Widget AddRemoveButton(){
    return Row(
      children: <Widget>[
        SizedBox(width: 165),
        InkWell(
          // onTap: doSomething,
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
               // color: Colors.blue
              ),
              child: Text(
                "Add/Remove",style: TextStyle(
                decoration: TextDecoration.underline,color: Colors.black, fontSize: 16.0,
              ),
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget PriceDetails(int check)
  {
    num_of_days=3;
    if(num_of_days>=1 && check==1)
      {
        return Row(

          children: <Widget>[
           // SizedBox(height: 80),
            Container(
              child:  Text("12.08.2020",
                style: TextStyle(color: Colors.black, fontSize: 16.0),),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(
                children: <Widget>[
                  Text("Morning\nEvening\nNight",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(

                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
          ],
        );
      }
    else if(num_of_days>=2 && check==2)
      {
        return Row(
          children: <Widget>[
            SizedBox(height: 80),
            Container(
              child:  Text("13.08.2020",
                style: TextStyle(color: Colors.black, fontSize: 16.0),),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(
                children: <Widget>[
                  Text("Morning\nEvening\nNight",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(

                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
          ],
        );
      }
    else if(num_of_days>=3 && check==3)
      {
        return Row(
          children: <Widget>[
            SizedBox(height: 80),
            Container(
              child:  Text("14.08.2020",
                style: TextStyle(color: Colors.black, fontSize: 16.0),),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(
                children: <Widget>[
                  Text("Morning\nEvening\nNight",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
            SizedBox(width: 100),
            Container(
              child: new Column(

                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ],
              ),
            ),
          ],
        );
      }
    else {
      return Container();
    }
  }
  Widget TotalPrice(){
    return Row(
      children: <Widget>[
        SizedBox(height: 50),
        SizedBox(width: 255),
        Container(
          child:  Text("Total",
            style: TextStyle(color: Colors.black, fontSize: 16.0),),
        ),

        SizedBox(width: 50),
        Container(
          child: new Column(
            children: <Widget>[
              Text("90000\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0),),
            ],
          ),
        ),
      ],
    );
  }
  Widget Facilities(){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(

              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 10.0),
                  child : Text("\nFacilities",
                      style: TextStyle(color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),


              ]
          ),
          AC(),
          WiFi(),
          CC(),
          PhotoShoots(),
          Parkinglot(),
        ],
      ),
    );
  }

  Widget Miscellanous(){
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(

              children: <Widget>[
                Container(
                  margin: new EdgeInsets.symmetric(vertical: 10.0),
                  child: Text("\nMiscellanous",
                      style: TextStyle(color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold)),
                ),
              ]
          ),
          Structure(),
          FireWorks(),
          FireExting(),
        ],
      ),
    );
  }
  Widget myPhotoList(String img) {
    return Container(

      child: new GestureDetector(
        child: Image.network(
            img,fit: BoxFit.fill),
        onTap: () {
          //print("naam holo "+convention.Name);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageList(convention: convention)));
        },
      ),
    );
  }

  Widget AC() {
    if (convention.facility[0] == '1') {
      return Row(
          children: <Widget>[
            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text("Air Conditioning",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }

  Widget WiFi() {
    if (convention.facility[1] == '1') {
      return Row(
          children: <Widget>[

            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text("Free Wifi",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }

  Widget CC() {
    if (convention.facility[2] == '1') {
      return Row(
          children: <Widget>[

            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text("Surveilled by CC camera",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }

  Widget PhotoShoots() {
    if (convention.facility[3] == '1') {
      return Row(
          children: <Widget>[

            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text("Special corner for photoshoots",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }
  Widget Parkinglot() {
      return Row(
          children: <Widget>[

            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text(convention.parking +" square feet parking lot",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
  }

  Widget Structure() {


    if (convention.facility[4] == '1') {
      return Row(
          children: <Widget>[

            Icon(Icons.fiber_manual_record, color: Color(0xFF005e6a),size: 16,),
            Text("Duplex structure",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[

            Icon(Icons.fiber_manual_record, color: Color(0xFF005e6a),size: 16,),
            Text("Simplex structure",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
  }

  Widget FireWorks() {
    if (convention.facility[5]=='1') {
      return Row(
          children: <Widget>[

            Icon(Icons.fiber_manual_record, color: Color(0xFF005e6a),size: 16,),
            Text("Reserved place for fireworks",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }

  Widget FireExting() {

    if (convention.facility[6]=='1') {
      return Row(
          children: <Widget>[

            //leading: new MyBullet(),
            Icon(Icons.fiber_manual_record, color: Color(0xFF005e6a),size: 16,),
            Text("Modern fire extinguishing facilities",
             style: TextStyle(color: Colors.black, fontSize: 16.0),),

          ]
      );
    }
    else {
      return Row(
          children: <Widget>[
          ]
      );
    }
  }


}
