import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  String image;
  DisplayImage({this.image});
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          //title: Text("Pa"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.black,
        ),
        body: new Center(
          child: Image.network(
              image,fit: BoxFit.fill),
        ),
      ),
    );
  }
}
