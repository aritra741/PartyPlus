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
  conventionHall convention ;
  _conventionHallDetailsState(this.convention);
  String str;

  GoogleMapController mapController;
  List<Marker>locations= <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      str= convention.Name;
      locations.add(
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(24.887635,91.874310),
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

   body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1500,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          staggeredTiles: [
            StaggeredTile.count(2, 1),
            StaggeredTile.count(2 ,1),

            StaggeredTile.count(1,1),
          StaggeredTile.count(1, 1),

          StaggeredTile.count(1, 1),
            StaggeredTile.count(1, 1),
            StaggeredTile.count(4, 4),

          ],

          children: <Widget>[
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
            Details(),
            Container(
              color: Colors.black,
              height: 100,
              child: Text(
                "eije kichhu"
              ),
            )
          ],


        ),


      ),


    ),
    );
  }

  Widget Details() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ListView(
          children: <Widget>[
            SizedBox(height:20.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(convention.Name,
                  style: TextStyle(color: Colors.black, fontSize: 30.0,fontWeight: FontWeight.bold),),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 300,
                  width: 400,
                  child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(24.887635,91.874310),
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
                  Text( convention.street+"," + convention.City,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ]
            ),
           /* Row(
                children: <Widget>[
                //  String str;
                  //Text("Hi"),
                  Icon(Icons.location_on),
                  Text( convention.street+"," + convention.City,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),),
                ]
            ),*/
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
  Widget myPhotoList(String img){
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
  /*String Facility(String str){
    String ret;
    if(str[0]=='1')

  }*/
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