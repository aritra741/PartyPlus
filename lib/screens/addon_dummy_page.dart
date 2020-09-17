import 'package:flutter/material.dart';

class AddOnDummy extends StatefulWidget {
  @override
  _AddOnDummyState createState() => _AddOnDummyState();
}

class _AddOnDummyState extends State<AddOnDummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
      ),
      body: Container(
        height: 500,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    size: 50,
                  ),
                  Text("Photography",
                  style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Price starting from \u09F35000",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.teal
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.card_travel,
                    size: 50,
                  ),
                  Text("Car rental",
                    style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Price starting from \u09F310000",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.brush,
                    size: 50,
                  ),
                  Text("Beauty Parlour",
                    style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Price starting from \u09F310000",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.fastfood,
                    size: 50,
                  ),
                  Text("Catering",
                    style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Price starting from \u09F310000",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.lightbulb_outline,
                    size: 50,
                  ),
                  Text("Decoration",
                    style: TextStyle(fontSize: 20),),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Price starting from \u09F310000",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            )
          ],
        )
      )
    );
  }
}
