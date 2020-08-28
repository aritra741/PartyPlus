import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'conventionHall.dart';

class conventionHallDetails extends StatefulWidget {
  conventionHall convention ;
  conventionHallDetails({this.convention});
  @override
  _conventionHallDetailsState createState() => _conventionHallDetailsState(convention);
}

class _conventionHallDetailsState extends State<conventionHallDetails> {
  conventionHall convention ;
  _conventionHallDetailsState(this.convention);
 // String str = convention.Name;
  @override
  Widget build(BuildContext context) {
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

          ],

          children: <Widget>[
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),
            myPhotoList("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),

          ],

        ),

      ),


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