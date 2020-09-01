import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partyplus/providers/conventionHall.dart';

class conventionHallDetails extends StatefulWidget {
  conventionHall convention ;
  conventionHallDetails({this.convention});
  @override
  _conventionHallDetailsState createState() => _conventionHallDetailsState(convention);
}

class _conventionHallDetailsState extends State<conventionHallDetails> {
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
          height: 1500,
          decoration: BoxDecoration(
            color: Colors.black12,
          ),
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            staggeredTiles: [
              StaggeredTile.count(2, 1),
              StaggeredTile.count(2, 1),

              StaggeredTile.count(1, 1),
              StaggeredTile.count(1, 1),

              StaggeredTile.count(1, 1),
              StaggeredTile.count(1, 1),
              StaggeredTile.count(4, 7),
             // StaggeredTile.count(4, 5),
            //  StaggeredTile.count(4, 5),

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
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),
              myPhotoList(
                  "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
              Details(),
              //Facilities(),
              //Miscellanous(),
              Container(
                color: Colors.black,
                height: 100,
                child: Text(
                    "eije kichhu"
                ),
              )
            ],


          ),
          //hildren: <Widget>[],
         /* child: ListView(
              children: <Widget>[

                StaggeredGridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  staggeredTiles: [
                    StaggeredTile.count(2, 1),
                    StaggeredTile.count(2, 1),

                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),

                    StaggeredTile.count(1, 1),
                    StaggeredTile.count(1, 1),
                   // StaggeredTile.count(4, 4),
                    //StaggeredTile.count(4, 5),
                    //StaggeredTile.count(4, 5),

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
                    myPhotoList(
                        "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),
                    myPhotoList(
                        "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
                  //  Details(),
                  //  Facilities(),
                   // Miscellanous(),
                  ],


                ),

              ],
          ),*/




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
          /*Row(
              children: <Widget>[
                //  String str;
                //Text("Hi"),
                AC(),
                WiFi(),
                CC(),
                PhotoShoots(),
                Parkinglot(),
              ]
            ),*/
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
     /* Row(
          children: <Widget>[

            Icon(Icons.check_box, color: Color(0xFF005e6a)),
            Text("Duplex structure",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ]
      ),*/
         Structure(),
          FireWorks(),
          FireExting(),


          /*Align(
              alignment: Alignment.centerLeft,


              /*child: Container(

                /*child: Text( convention.street+"," + convention.City,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),*/
              ),*/
            ),*/
        ],
      ),
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
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              img),
        ),
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



/*class conventionHallDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
      ),
      body: Center(
        child: Text(
          "kaj korse",
        ),
      ),
    );


  }

}*/