import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'package:partyplus/screens/confirm_booking.dart';
import 'ImageList.dart';
import 'package:partyplus/screens/modify_reservation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class conventionHallDetails extends StatefulWidget {
  int num_of_days = 2;
  conventionHall convention;

  String searchstring, dayString;
  DateTime selectedDate, secDate, thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;

  conventionHallDetails(
      {this.convention,
      this.searchstring,
      this.dayString,
      this.selectedDate,
      this.secDate,
      this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift});

  @override
  _conventionHallDetailsState createState() => _conventionHallDetailsState(
      convention, searchstring, dayString, selectedDate, secDate, thDate,dayOneShift, dayTwoShift, dayThreeShift);
}

class _conventionHallDetailsState extends State<conventionHallDetails> {
  int num_of_days = 2;
  conventionHall convention;
  String searchstring, dayString;
  DateTime selectedDate, secDate, thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;

  List<String> imageList;
  _conventionHallDetailsState(this.convention, this.searchstring,
      this.dayString, this.selectedDate, this.secDate, this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift);

  String str;
  String shiftBitstr1="",shiftBitstr2="",shiftBitstr3="";
  String shiftTextstr1,shiftTextstr2,shiftTextstr3;
  String takatext1,takatext2,takatext3;
  String date1,date2,date3;
  int total_cost= 0;

  GoogleMapController mapController;
  List<Marker> locations = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List<String>> postData() async{

    var match = {
      "id" : convention.Id
    };

    print( json.encode(match) );

    print("HYSE??");
    final String apiurl = "http://partyplusapi.herokuapp.com/images";
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

    imageList = (jsonDecode(response.body) as List<dynamic>).cast<String>();
    print(imageList);
    for(int i=0;i<imageList.length;i++)
    print(imageList[i]);

    return imageList;
  }
  @override
  void initState(){
    super.initState();
    //imageList = new List();
    postData();
    ShiftString();
    if(dayString=="1") num_of_days=1;
    else if(dayString=="2") num_of_days=2;
    else num_of_days=3;
  }
  @override
  Widget build(BuildContext context) {

    date1 = "${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}";
    date2 = "${secDate.day.toString()}-${secDate.month.toString()}-${secDate.year.toString()}";
    date3 = "${thDate.day.toString()}-${thDate.month.toString()}-${thDate.year.toString()}";
    setState(() {
      str = convention.Name;
      locations.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(24.887635, 91.874310),
          infoWindow: InfoWindow(title: 'International Convention City')));
    });

    return FutureBuilder(
      future: postData(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if( snapshot.data!=null ) {
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
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              //color: Colors.white12,
              padding: const EdgeInsets.all(1.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  StaggeredGridView.count(
                    shrinkWrap: true,
                    // primary: false,
                    crossAxisCount: 6,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: [
                      StaggeredTile.count(3, 2),
                      StaggeredTile.count(3, 2),
                      StaggeredTile.count(2, 1.8),
                      StaggeredTile.count(2, 1.8),
                      StaggeredTile.count(2, 1.8),
                    ],

                    children: <Widget>[
                      myPhotoList(
                          imageList[0]),
                      // "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage1.jpg?alt=media&token=fb301e5b-3c2b-4cce-83ab-dae21de6f6c3"),
                      myPhotoList(
                          imageList[1]),
                      // "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage2.jpg?alt=media&token=c6e48821-38c6-446a-864b-e15410ff5bd2"),
                      myPhotoList(
                          imageList[2]),
                      // "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage3.jpg?alt=media&token=3aec3f2b-2e1d-4fa8-920d-1b0bd6cbacf1"),
                      myPhotoList(
                          imageList[3]),
                      // "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage4.jpg?alt=media&token=3cdb57db-ec30-433c-b508-acbf70a0df51"),
                      Stack(
                        children: <Widget>[
                          myPhotoList(
                              imageList[4]),
                          // "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Khan's%20Palace%2Fimage5.jpg?alt=media&token=d59484f1-2ee8-4a63-8787-8c9a0c9f13db"),
                          Container(
                            child: new GestureDetector(
                              onTap: () {
                                //print("naam holo "+convention.Name);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImageList(convention: convention)));
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageList(convention: convention,
                                                  imageList: imageList)));
                                },
                                child: Text(
                                  (imageList.length - 5).toString() + "+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //ekhane shesh
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        convention.Name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
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
                            onMapCreated: _onMapCreated)),
                  ),
                  Row(children: <Widget>[
                    //Text("Hi"),
                    Icon(
                      Icons.location_on,
                      size: 40,
                      color: Color(0xFFEA4335),
                    ),
                    Text(
                      convention.street + "," + convention.City,
                      style: TextStyle(color: Colors.black, fontSize: 28.0),
                    ),
                  ]),
                  Card(
                      elevation: 20,
                      child: Container(
                        // margin: new EdgeInsets.symmetric(vertical: 10.0),
                        height: 200,
                        child: Column(
                          children: <Widget>[
                            Text("\nFacilities",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                            AC(),
                            WiFi(),
                            CC(),
                            PhotoShoots(),
                            Parkinglot(),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  Card(
                    elevation: 20,
                    child: Container(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Text("\nMiscellaneous",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold)),
                          Structure(),
                          FireWorks(),
                          FireExting(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 30,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 400,
                      child: Column(
                        children: <Widget>[
                          if(num_of_days >= 1)
                            PriceDetails(1),
                          if(num_of_days >= 1)
                            AddRemoveButton(),
                          if(num_of_days >= 2)
                            widgetforszbox(2),
                          if(num_of_days >= 2)
                            PriceDetails(2),
                          if(num_of_days >= 2)
                            AddRemoveButton(),
                          if(num_of_days >= 3)
                            widgetforszbox(3),
                          if(num_of_days >= 3)
                            PriceDetails(3),
                          if(num_of_days >= 3)
                            AddRemoveButton(),
                          widgetforszbox(4),
                          TotalPrice(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConfirmBooking(
                                          convention: convention,
                                          searchstring: searchstring,
                                          dayString: dayString,
                                          selectedDate: selectedDate,
                                          secDate: secDate,
                                          thDate: thDate,
                                          dayOneShift: dayOneShift,
                                          dayTwoShift: dayTwoShift,
                                          dayThreeShift: dayThreeShift)));
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFF005e6a),
                        child: Text(
                          'BOOK',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
        else
          return Center(child:
            SizedBox( width: 30, height: 30, child: CircularProgressIndicator()));
      },
    );
  }

  void ShiftString()
  {
    print("Ss");
    //String s;
    shiftBitstr1="";
    shiftBitstr2="";
    shiftBitstr3="";
    shiftTextstr1 = "";
    shiftTextstr2 = "";
    shiftTextstr3 = "";
    takatext1="";
    takatext2="";
    takatext3="";
    total_cost = 0;
    List<String> shft = ['Morning','Evening','NIght'];
    for(int i=0;i<3;i++)
    {
      print(dayOneShift[i]);
      print(dayTwoShift[i]);
      print(dayThreeShift[i]);
    }

    for(int i=0;i<3;i++)
    {
      if(dayOneShift[i]==true)
      {

        shiftBitstr1 += "1";
        if(shiftTextstr1!="") shiftTextstr1+="\n";
        if(takatext1!="") takatext1+="\n";
        takatext1+=convention.mxprice.toString();
        takatext1 += "\u09F3";
        shiftTextstr1 += shft[i];
        total_cost += int.parse(convention.mxprice);
      }
      else shiftBitstr1 +=  "0";
      if(dayTwoShift[i]==true)
      {
        shiftBitstr2+="1";
        if(shiftTextstr2!="") shiftTextstr2+="\n";
        if(takatext2!="") takatext2+="\n";
        takatext2+=convention.mxprice.toString();
        takatext2 += "\u09F3";
        shiftTextstr2 += shft[i];
        total_cost += int.parse(convention.mxprice);
      }
      else shiftBitstr2 += "0'";
      if(dayThreeShift[i]==true)
      {
        shiftBitstr3+= "1";
        if(shiftTextstr3!="") shiftTextstr3+="\n";
        if(takatext3!="") takatext3+="\n";
        takatext3+=convention.mxprice.toString();
        takatext3 += "\u09F3";
        shiftTextstr3 += shft[i];
        total_cost += int.parse(convention.mxprice);
      }
      else shiftBitstr3 += "0";
      print(shiftBitstr1);
    }
    return;
  }

  Widget widgetforszbox(int n) {
    if (num_of_days >= 2 && n == 2)
      return SizedBox(
        height: 10,
      );
    else if (num_of_days >= 3 && n == 3)
      return SizedBox(
        height: 10,
      );
    else if (n == 4)
      return SizedBox(
        height: 10,
      );
  }

  Widget AddRemoveButton() {
    return Row(
      children: <Widget>[
        SizedBox(width: 145),
        InkWell(
          // onTap: doSomething,
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.blue
                  ),
              child: InkWell(
                  onTap: () => {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              bool _morning = true;
                              bool _evening = true;
                              bool _night = true;

                              return AlertDialog(
                                title: Text("Shift(s)"),
                                actions: <Widget>[
                                  new FlatButton(
                                      onPressed: () {
                                        // setNumberOfDays();
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 50,
                                        padding:
                                            EdgeInsets.only(left: 11, top: 5),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF005e6a),
                                        ),
                                        child: Text("ok",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white)),
                                      ))
                                ],
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CheckboxListTile(
                                          value: _morning,
                                          title: Text("Morning"),
                                          onChanged: (value) {
                                            setState(() {
                                              _morning = value;
                                              // getShiftInfoForDayOne(_morning, _evening, _night);
                                            });
                                          },
                                        ),
                                        CheckboxListTile(
                                          value: _evening,
                                          title: Text("Evening"),
                                          onChanged: (value) {
                                            setState(() {
                                              _evening = value;
                                              // getShiftInfoForDayOne(_morning, _evening, _night);
                                            });
                                          },
                                        ),
                                        CheckboxListTile(
                                          value: _night,
                                          title: Text("Night"),
                                          onChanged: (value) {
                                            setState(() {
                                              _night = value;
                                              // getShiftInfoForDayOne(_morning, _evening, _night);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            })
                      },
                  child: Text(
                    "Add/Remove",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                      fontSize: 16.0,
                    ),
                  )
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

    if(num_of_days>=1 && check==1)
    {
      return Row(

        children: <Widget>[
          // SizedBox(height: 80),
          Container(
            child:  Text(date1,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr1,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext1,
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
          Container(
            child:  Text(date2,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr2,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext2,
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
          // SizedBox(height: 80),
          Container(
            child:  Text(date3,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr3,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext3,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Row(children: <Widget>[
        Text("d")
      ],);
    }
  }

  Widget TotalPrice(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 170),
        Container(
            child:  Text("Total",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 93),
        Container(
          child: new Column(
            children: <Widget>[
              Text((total_cost).toString() + "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }

  Widget Facilities() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
              child: Text("\nFacilities",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
          AC(),
          WiFi(),
          CC(),
          PhotoShoots(),
          Parkinglot(),
        ],
      ),
    );
  }

  Widget Miscellanous() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(1.0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(vertical: 10.0),
              child: Text("\nMiscellanous",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
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
        child: Image.network(img, fit: BoxFit.fill),
        onTap: () {
          //print("naam holo "+convention.Name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageList(convention: convention)));
        },
      ),
    );
  }

  Widget AC() {
    if (convention.facility[0] == '1') {
      return Row(children: <Widget>[
        Icon(Icons.check, color: Color(0xFF00ff00)),
        Text(
          "Air Conditioning",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }

  Widget WiFi() {
    if (convention.facility[1] == '1') {
      return Row(children: <Widget>[
        Icon(Icons.check, color: Color(0xFF00ff00)),
        Text(
          "Free Wifi",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }

  Widget CC() {
    if (convention.facility[2] == '1') {
      return Row(children: <Widget>[
        Icon(Icons.check, color: Color(0xFF00ff00)),
        Text(
          "Surveilled by CC camera",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }

  Widget PhotoShoots() {
    if (convention.facility[3] == '1') {
      return Row(children: <Widget>[
        Icon(Icons.check, color: Color(0xFF00ff00)),
        Text(
          "Special corner for photoshoots",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }

  Widget Parkinglot() {
    return Row(children: <Widget>[
      Icon(Icons.check, color: Color(0xFF00ff00)),
      Text(
        convention.parking + " square feet parking lot",
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    ]);
  }

  Widget Structure() {
    if (convention.facility[4] == '1') {
      return Row(children: <Widget>[
        Icon(
          Icons.fiber_manual_record,
          color: Color(0xFF005e6a),
          size: 16,
        ),
        Text(
          "Duplex structure",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[
        Icon(
          Icons.fiber_manual_record,
          color: Color(0xFF005e6a),
          size: 16,
        ),
        Text(
          "Simplex structure",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    }
  }

  Widget FireWorks() {
    if (convention.facility[5] == '1') {
      return Row(children: <Widget>[
        Icon(
          Icons.fiber_manual_record,
          color: Color(0xFF005e6a),
          size: 16,
        ),
        Text(
          "Reserved place for fireworks",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }

  Widget FireExting() {
    if (convention.facility[6] == '1') {
      return Row(children: <Widget>[
        //leading: new MyBullet(),
        Icon(
          Icons.fiber_manual_record,
          color: Color(0xFF005e6a),
          size: 16,
        ),
        Text(
          "Modern fire extinguishing facilities",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ]);
    } else {
      return Row(children: <Widget>[]);
    }
  }
}
