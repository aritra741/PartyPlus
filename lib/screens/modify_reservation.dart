import 'package:flutter/material.dart';
import 'package:partyplus/constants/constants_for_login.dart';
import 'package:partyplus/screens/addon_dummy_page.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ModifyReservation extends StatefulWidget {
  Map data= new Map();
  Map halldata= new Map();
  ModifyReservation({this.data, this.halldata });
  @override
  _ModifyReservationState createState() => _ModifyReservationState(data, halldata);
}

class _ModifyReservationState extends State<ModifyReservation> {

  Map data= new Map();
  Map halldata= new Map();
  _ModifyReservationState(this.data, this.halldata);
  var userEmail= TextEditingController();
  var userPhone= TextEditingController();
  var userName= TextEditingController();
  int currentIndex= 1;
  int num_of_days= 3, check= 3;
  bool _inAsyncCall= false;
  bool pressed= false;
  String shiftTextstr1="",shiftTextstr2="",shiftTextstr3="";
  List<bool> dayOneShift = [false,false,false], dayTwoShift = [false,false,false], dayThreeShift = [false,false,false];
  String shiftBitstr1="",shiftBitstr2="",shiftBitstr3="";
  String takatext1,takatext2,takatext3;
  String price1,price2,price3;

  GoogleMapController mapController;
  List<Marker> locations = <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  double total_cost= 0,vat=0;

  Future updateData() async
  {
    // print( json.encode(data) );

    print("HYSE??");
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/reservation";
    //http.Response response = await http.post(apiurl);
    /* final response = await http.post(apiurl,body: {
      "name" : searchstring
    });*/
    http.Response response;
    try{
      response= await http.put(apiurl,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data,
          encoding: Encoding.getByName("utf-8"));
    }catch(e) {
      print("error holo "+e.toString());
    };

    //print("HYSE??");
    // body: json.encode(match),);
    //  data = json.decode(response.body);
    //  debugPrint(fuserData.toString());
    //  setState(() {
    //    fuserData = data['Name'];
    //  });
    //  debugPrint(fuserData.toString());
    // print(data);
    //  return fuserData;
  }

  Future cancelReservation() async{
    // print( json.encode(data) );

    var match= {
      "id": data['key']
    };

    print("HYSE??");
    print(match);
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/cancel";
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
      print("error holo "+e.toString());
    };

    //print("HYSE??");
    // body: json.encode(match),);
    //  data = json.decode(response.body);
    //  debugPrint(fuserData.toString());
    //  setState(() {
    //    fuserData = data['Name'];
    //  });
    //  debugPrint(fuserData.toString());
    // print(data);
    return response.body;
  }

  @override
  void dispose() {
    userEmail.dispose();
    userName.dispose();
    userPhone.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();

    setState((){
      userEmail.text = data['email'];
      userPhone.text = data['phoneNumber'];
      userName.text = data['name'];
      if(data['numofdays']=="1") num_of_days=1;
      else if(data['numofdays']=="2") num_of_days=2;
      else num_of_days=3;
      makeshift();
      ShiftString();
    });

    print("eeeeeeeeeeeeeeeeeeehehhhhhhhhhe");
    // ShiftString();
  }
  void makeshift()
  {
    shiftTextstr1="";
    shiftTextstr2="";
    shiftTextstr3="";
    List<String> shft = ['Morning','Noon','Evening'];
    /*for( int i=0;i<3;i++ )
    {
      dayOneShift.add(false);
      dayTwoShift.add(false);
      dayThreeShift.add(false);
    }*/
    for(int i=0;i<3;i++)
    {
      if(i < data['shift1'].length && data['shift1'][i]=='1')
      {
        if(shiftTextstr1!=null) shiftTextstr1+="\n";
        dayOneShift[i] = true;
        shiftTextstr1 += shft[i];
      }
      if(i < data['shift2'].length && data['shift2'][i]=='1')
      {
        dayTwoShift[i] = true;
        if(shiftTextstr2!=null) shiftTextstr2+="\n";
        shiftTextstr2 += shft[i];
      }
      if( i < data['shift3'].length && data['shift3'][i]=='1')
      {
        dayThreeShift[i] = true;
        if(shiftTextstr3!=null) shiftTextstr3+="\n";
        shiftTextstr3 += shft[i];
      }

    }
    //total_cost = data['totalCost'];
    return;
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
    String mxprice = "100000";
    List<String> shft = ['Morning','Noon','Evening'];
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
        takatext1+=mxprice;
        takatext1 += "\u09F3";
        shiftTextstr1 += shft[i];
        total_cost += double.parse(mxprice);
      }
      else shiftBitstr1 +=  "0";
      if(dayTwoShift[i]==true)
      {
        shiftBitstr2+="1";
        if(shiftTextstr2!="") shiftTextstr2+="\n";
        if(takatext2!="") takatext2+="\n";
        takatext2+=mxprice;
        takatext2 += "\u09F3";
        shiftTextstr2 += shft[i];
        total_cost += double.parse(mxprice);
      }
      else shiftBitstr2 += "0";
      if(dayThreeShift[i]==true)
      {
        shiftBitstr3+= "1";
        if(shiftTextstr3!="") shiftTextstr3+="\n";
        if(takatext3!="") takatext3+="\n";
        takatext3+=mxprice;
        takatext3 += "\u09F3";
        shiftTextstr3 += shft[i];
        total_cost += double.parse(mxprice);
      }
      else shiftBitstr3 += "0";
      print(shiftBitstr1);
    }

    vat = total_cost*0.15;
    total_cost*= 1.15;
    return;
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      locations.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(24.887635, 91.874310),
          infoWindow: InfoWindow(title: 'International Convention City')));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PartyPlus",
        ),
        backgroundColor: Color(0xFF005e6a),
      ),
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[

              Image.network(halldata['Image'],fit: BoxFit.cover),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Text(
                    data['convname'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 5.0),
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
                  halldata['Street'] + "," + halldata['City'],
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
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
                        Seating_cap(),
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
              Container(
                alignment: Alignment.center,
                decoration: kBoxDecorationStyleDiffColor,
                height: 60.0,
                margin: EdgeInsets.all(10),

                child: TextField(
                  controller: userName,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: kBoxDecorationStyleDiffColor,
                height: 60.0,
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: userEmail,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: kBoxDecorationStyleDiffColor,
                height: 60.0,
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: userPhone,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: true,
                child: Card(
                  elevation: 30,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    height: 320,
                    child: Column(
                      children: <Widget>[
                        if(num_of_days>=1)
                          PriceDetails(1),
                        if(num_of_days >= 1)
                          AddRemoveButton1(),
                        if(num_of_days>=2)
                          widgetforszbox(2),
                        if(num_of_days>=2)
                          PriceDetails(2),
                        if(num_of_days >= 2)
                          AddRemoveButton2(),
                        if(num_of_days>=3)
                          widgetforszbox(3),
                        if(num_of_days>=3)
                          PriceDetails(3),
                        if(num_of_days >= 3)
                          AddRemoveButton3(),
                        SizedBox(height: 10,),
                        VAT(),
                        SizedBox(height: 10,),
                        ServiceFee(),
                        widgetforszbox(4),
                        TotalPrice(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: kDefaultPadding),
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: (){
                          setState(() {
                            pressed= true;
                            _inAsyncCall= true;
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddOnDummy()));
                          });

                          cancelReservation().then((value) => {

                            setState((){
                              _inAsyncCall= false;
                            }),

                            Fluttertoast.showToast(
                              msg: "Reservation Cancelled Successfully ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                            ),

                            Navigator.pop(context)
                          });

                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFF005e6a),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),

                    Container(
                      margin: EdgeInsets.only(top: kDefaultPadding),
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: (){
                          setState(() {
                            pressed= true;
                            _inAsyncCall= true;
                            // price1=  takatext1.substring(0, takatext1.length - 1);
                            // price2=  takatext1.substring(0, takatext2.length - 1);
                            // price3=  takatext1.substring(0, takatext3.length - 1);

                            // print("price holo"+price1);

                            data['shift1']= shiftBitstr1;
                            data['shift2']= shiftBitstr2;
                            data['shift3']= shiftBitstr3;
                            data['price1']= takatext1;
                            data['price2']= takatext2;
                            data['price3']= takatext3;
                            data['totalCost']= total_cost.ceil().toString();
                            data['email']= userEmail.text;
                            data['name']= userName.text;
                            data['phoneNumber']= userPhone.text;
                          });

                          updateData().then((value) => {

                            setState((){
                              _inAsyncCall= false;
                            }),

                            Fluttertoast.showToast(
                              msg: "Reservation Updated",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                            )
                          });
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Color(0xFF005e6a),
                        child: Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        inAsyncCall: _inAsyncCall,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
  Widget VAT(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 115),
        Container(
            child:  Text("VAT(15%)",
                style: TextStyle(color: Colors.black, fontSize: 16.0,))
        ),

        SizedBox(width: 60),
        Container(
          child: new Column(
            children: <Widget>[
              Text(vat.ceil().toString()+ "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,),),
            ],
          ),
        ),
      ],
    );
  }
  Widget ServiceFee(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 110),
        Container(
            child:  Text("Service Fee",
                style: TextStyle(color: Colors.black, fontSize: 16.0,))
        ),

        SizedBox(width: 70),
        Container(
          child: new Column(
            children: <Widget>[
              Text("0" + "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,),),
            ],
          ),
        ),
      ],
    );
  }

  Widget widgetforszbox(int n){
    if(num_of_days>=2 && n==2)
      return SizedBox(height: 10,);
    else if(num_of_days>=3 && n==3)
      return SizedBox(height: 10,);
    else if(n==4)
      return SizedBox(height: 10,);
  }

  Widget PriceDetails(int check)
  {

    if(num_of_days>=1 && check==1)
    {
      return Row(

        children: <Widget>[
          // SizedBox(height: 80),
          Container(
            child:  Text(data['date1'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr1,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
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
            child:  Text(data['date2'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr2,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
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
            child:  Text(data['date3'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr3,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
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
        SizedBox(width: 130),
        Container(
            child:  Text("Total",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 70),
        Container(
          child: new Column(
            children: <Widget>[
              Text((total_cost.ceil()).toString()+ "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }

  Widget AddRemoveButton1() {
    return Row(
      children: <Widget>[
        SizedBox(width: 100),
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
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      ShiftString();
                                    });
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
                                      value: dayOneShift[0],
                                      title: Text("Morning (9am - 3pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    /*CheckboxListTile(
                                      value: dayOneShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),*/
                                    CheckboxListTile(
                                      value: dayOneShift[2],
                                      title: Text("Evening (4pm - 11pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[2] = value;
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

  Widget AddRemoveButton2() {
    return Row(
      children: <Widget>[
        SizedBox(width: 100),
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
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {

                                    setState(() {
                                      ShiftString();
                                    });
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
                                      value: dayTwoShift[0],
                                      title: Text("Morning (9am - 3pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    /*CheckboxListTile(
                                      value: dayTwoShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),*/
                                    CheckboxListTile(
                                      value: dayTwoShift[2],
                                      title: Text("Evening (4pm - 11pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[2] = value;
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

  Widget AddRemoveButton3() {
    return Row(
      children: <Widget>[
        SizedBox(width: 100),
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
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      ShiftString();
                                    });
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
                                      value: dayThreeShift[0],
                                      title: Text("Morning (9am - 3pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    /*CheckboxListTile(
                                      value: dayThreeShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),*/
                                    CheckboxListTile(
                                      value: dayThreeShift[2],
                                      title: Text("Evening (4pm - 11pm)"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[2] = value;
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

  Widget AC() {
    if (halldata['Facility'][0] == '1') {
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
    if (halldata['Facility'][1] == '1') {
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
    if (halldata['Facility'][2] == '1') {
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
    if (halldata['Facility'][3] == '1') {
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
        halldata['Parking'] + " square feet parking lot",
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    ]);
  }
  Widget Seating_cap() {
    return Row(children: <Widget>[
      Icon(Icons.check, color: Color(0xFF00ff00)),
      Text(
        halldata['Sitting_cap'] + " seating capacity",
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    ]);
  }

  Widget Structure() {
    if (halldata['Facility'][4] == '1') {
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
    if (halldata['Facility'][5] == '1') {
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
    if (halldata['Facility'][6] == '1') {
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