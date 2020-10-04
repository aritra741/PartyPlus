
import 'package:flutter/material.dart';
import 'package:partyplus/DisplayImage.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'package:partyplus/conventionHallDetails.dart';

class ImageList extends StatefulWidget {
  conventionHall convention ;
  List<String>imageList;
  ImageList({this.convention,this.imageList});
  @override
  _ImageListState createState() => _ImageListState(convention,imageList);
}

class _ImageListState extends State<ImageList> {
  conventionHall convention;
  List<String>imageList;
  _ImageListState(this.convention,this.imageList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(convention.Name),
        backgroundColor: Color(0xFF005e6a),
      ),

     body: new Container(
        child: new ListView.builder(
            itemCount:  imageList.length,
            itemBuilder: (_,index){
              return ImgList(imageList[index]);
            }
        ),
      ),
    );
  }



  @override
  void initState(){
    super.initState();
   /* list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3");
    list.add( "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3");
    list.add( "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51");
    list.add("https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db");

    */
  }

  Widget ImgList(String image)
  {
    return new Card(
      elevation: 10.0,
      //margin: EdgeInsets.all(15.0),

      child: new InkWell(
        onTap: () {
        //  print("naam holo "+convention.Name);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>DisplayImage(image: image)));
        },
        child: new Container(
          //padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            //  SizedBox(height: 10.0,),
              new Image.network(image,fit: BoxFit.cover),
             // SizedBox(height: 10.0,),

            ],
          ),
        ),
      ),
    );
  }
}
