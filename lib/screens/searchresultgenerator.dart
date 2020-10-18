import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_screen_body.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'package:partyplus/conventionHallDetails.dart';
import 'package:intl/intl.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SearchResultGenerator extends StatefulWidget {

  static int globalSelectedRadio;
  static List<bool> globalFiler= [false,false,false,false,false,false,false];
  static List<conventionHall> globalHallList= new List();

  bool type;
  bool cbxval = false;
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  SearchResultGenerator({this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift, this.type});
  @override
  _SearchResultGeneratorState createState() => _SearchResultGeneratorState(searchstring,dayString,selectedDate,secDate,thDate,dayOneShift, dayTwoShift, dayThreeShift, type);
}

class _SearchResultGeneratorState extends State<SearchResultGenerator> {
  double slid = 1000000.0;
  bool type;
  double parkslid = 0.0;
  double sittingslid = 0.0;
  int chosenprice = -1,chosenlot=-1;
  int chosensittingcap = -1;
  int selectedRadio;
  List<bool>filter = [false,false,false,false,false,false,false];
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  List<conventionHall> hallList = new List();
  List<conventionHall> AllHall = new List();

  _SearchResultGeneratorState(this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift, this.type);

  Future _postdata;

  Map data= new Map();
  List userData,fuserData;

  var search = {
    "name" : {"aaaa": "dddd"}
  };
  /*Future getData() async {
    http.Response response = await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
   // debugPrint(userData.toString());
    //print("hello");
  }*/

  Future<List<conventionHall>> postData() async{

    if(type==true)
      return SearchResultGenerator.globalHallList;

    var match = {
      "name" : searchstring
    };
    
    print( json.encode(match) );

    print("HYSE??");
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
    }

   //  print("done");
   // // body: json.encode(match),);

   // print("data holo "+data.toString());
   //  debugPrint(fuserData.toString());
   //  setState(() {
   //    fuserData = data['Name'];
   //  });
   //  debugPrint(fuserData.toString());

    hallList.clear();
    AllHall.clear();
    var jsonlist = jsonDecode(response.body) as List;
    jsonlist.forEach((e) {
      hallList.add(conventionHall.fromJson(e));
      AllHall.add(conventionHall.fromJson(e));
    });

    // data = json.decode(response.body);
    return hallList;
  }

  @override
  Widget build(BuildContext context) {
    var search = {
      "name" : searchstring
    };

   // var response = await post(Uri.parse("https://l.facebook.com/l.php?u=http%3A%2F%2Fpartyplusapi.herokuapp.com%2Fsearch%3Ffbclid%3DIwAR23PMRsfGcZolvbS6OhzHvi7f8M1xh_1IccNuxh0eiT_zKWumesa9JVG3M&h=AT0jBTSIaQpGhvxlZziUwCc3rfRMJyR2HbbxSqCkc3EI3dhd2UI7DTE_sYcivZyrxXSkV1unsAQ6OGHdZCuE1mG3_aa8o2o8Dtgd-QKF7EgBsC9uLUQk7LqNTmcZzLBW2dhcyQ"));
   //  print(search);
    print(SearchScreenBody.val);
    return FutureBuilder(
      future: _postdata,
      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        if( snapshot.data!=null )
          {
            print("entered");

            if(type==false)
              {
                Set<conventionHall>hallSet= Set.of(hallList);
                var val;

                hallList.clear();
                SearchResultGenerator.globalHallList.clear();

                for( val in hallSet )
                {
                  hallList.add(val);
                  SearchResultGenerator.globalHallList.add(val);
                }
              }
            else
              hallList= SearchResultGenerator.globalHallList;

            print("got value of size "+hallList.length.toString());

            return Scaffold(
              /*body: Center(
        child: Text(
          searchstring,
        ),
      ),*/
              body: new Container(
                child: ((hallList.length==1 && hallList[0].Name=='null'))?new Text("No result found",textAlign: TextAlign.center,) : new Column(
                  children: <Widget>[
                    if(hallList.length==0) Text("No result found",textAlign: TextAlign.center,),
                    new Expanded(child:
                    ListView.builder(
                        itemCount: hallList.length,
                        itemBuilder: (_,index){
                          return conventionUI(hallList[index].image, hallList[index].Name, hallList[index].City, hallList[index].street,hallList[index]);

                        }
                    ),
                    ),

                    Row(
                      children: <Widget>[
                        FlatButton(
                          // elevation: 5.0,
                          onPressed: () => showSortOptions(),
                          //  padding: EdgeInsets.all(15.0),
                          /*  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),*/
                          color: Color(0xFF005e6a),
                          child: Text(
                            'Sort',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        FlatButton(
                          // elevation: 5.0,
                          onPressed: () => showFilterDialog(),
                          //  padding: EdgeInsets.all(15.0),
                          /* shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),*/
                          color: Color(0xFF005e6a),
                          child: Text(
                            'Filter',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ],
                    ),
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
  List<conventionHall> list = [];
 // conventionHall test = new conventionHall("Sylhet", "cc", "Shubidh Bazar", "Khan's Palace", "1", "1110111", "1234", "1234", "1335", "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/khan.jpg?alt=media&token=267e9cc7-6646-4df0-bceb-a99e1b88360f", 12.3, 12.55);
 // conventionHall test2 = new conventionHall("Chittagong", "cc", "Main Road", "King of Chittagong", "1", "1110111", "1234", "1234", "1335", "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/king%20of%20chittagong.jpg?alt=media&token=003e5c26-53bc-47b8-ab29-654cb9f97028", 12.3, 12.55);
  //list.add(test);

  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    SearchResultGenerator.globalSelectedRadio= 0;
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("conventionHall");
  //  getData();
    _postdata= postData();
    //list.add(test);
    //list.add(test2);

   // String d = "${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}";
    print("s s " + dayString );
    print(hallList.length );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      SearchResultGenerator.globalSelectedRadio= val;
    });
  }


  Widget conventionUI(String image,String name,String city,String street,conventionHall convention)
  {
    return new Card(
      elevation: 10.0,
     // margin: EdgeInsets.all(15.0),

      child: new InkWell(
        onTap: () {
          print("naam holo "+convention.Name);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>conventionHallDetails(convention: convention,searchstring: searchstring,dayString:dayString,selectedDate:selectedDate,secDate:secDate,thDate:thDate,dayOneShift:dayOneShift,dayTwoShift: dayTwoShift, dayThreeShift: dayThreeShift)));
         // showFilterDialog();
         // showSortOptions();
        },
        child: new Container(
          padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    name,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                 /* new Text(
                    city,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  )*/
                ],
              ),
              SizedBox(height: 10.0,),
              new Image.network(image,fit: BoxFit.cover),
              SizedBox(height: 10.0,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on,
                            size: 20,
                            color: Color(0xFFEA4335),
                          ),
                        ),
                        TextSpan(
                          text: street + "," + city,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF32C809),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: new Text(
                      convention.mxprice+"\u09F3" + " per shift",
                      style: GoogleFonts.barlow(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showFilterDialog()
  {

    showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (BuildContext context)
        {
          return AlertDialog(
            insetPadding: EdgeInsets.all(5),
            title: new Text('Filter Options'),
            // content: new Text('Please enter correct Username and Password'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState)
              {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget> [
                        Checkbox(
                          value: filter[0],
                          onChanged: (bool value){
                            setState(() {
                              filter[0] = value;
                              SearchResultGenerator.globalFiler[0]= value;
                            });
                          },
                        ),
                        Text("AC"),
                        Checkbox(
                          value: filter[1],
                          onChanged: (bool value){
                            setState(() {
                              filter[1]= value;
                              SearchResultGenerator.globalFiler[1]= value;
                            });
                          },
                        ),
                        Text("Wifi"),
                        Checkbox(
                          value: filter[2],
                          onChanged: (bool value){
                            setState(() {
                              filter[2] = value;
                              SearchResultGenerator.globalFiler[2]= value;
                            });
                          },
                        ),
                        Text("CC Camera"),
                      ],
                    ),

                    Row(
                      children: <Widget> [
                        Checkbox(
                          value: filter[3],
                          onChanged: (bool value){
                            setState(() {
                              filter[3] = value;
                              SearchResultGenerator.globalFiler[3]= value;
                            });
                          },
                        ),
                        Text("Firework Place"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: filter[4],
                          onChanged: (bool value){
                            setState(() {
                              filter[4] = value;
                              SearchResultGenerator.globalFiler[4]= value;
                            });
                          },
                        ),
                        Text("Photoshoot Area"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: filter[5],
                          onChanged: (bool value){
                            setState(() {
                              print(value);
                              filter[5] = value;
                              SearchResultGenerator.globalFiler[5]= value;
                            });
                          },
                        ),
                        Text("Fire Control"),
                        Checkbox(
                          value: filter[6],
                          onChanged: (bool value){
                            setState(() {
                              print(value);
                              filter[6] = value;
                              SearchResultGenerator.globalFiler[6]= value;
                            });
                          },
                        ),
                        Text("Kitchen"),
                      ],
                    ),
                    Row(
                      children: <Widget> [
                        Text("   Structure",style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),

                    Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: selectedRadio,
                            activeColor: Color(0xFF005e6a),
                            onChanged: (int val) {
                              print("Radio $val");
                              setState(() {
                                print("sim $val");
                                selectedRadio = val;
                                SearchResultGenerator.globalSelectedRadio= val;
                              });
                            },
                          ),
                          Text("Simplex"),
                          Radio(
                            value: 2,
                            groupValue: selectedRadio,
                            activeColor: Color(0xFF005e6a),
                            onChanged: (int val) {
                              print("Radio $val");
                              setState(() {
                                print("dup $val");
                                selectedRadio = val;
                                SearchResultGenerator.globalSelectedRadio= val;
                              });
                            },
                          ),
                          Text("Duplex"),
                        ]
                    ),
                    Row(
                      children: <Widget>  [
                        Text("   Maximum Price",style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),

                      SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorColor:  Color(0xFF005e6a),
                  inactiveTrackColor: Colors.blueGrey,
                  activeTrackColor: Color(0xFF005e6a),
                  thumbColor: Colors.black,
                  trackHeight: 5,
                     overlayColor: Colors.transparent,
                     minThumbSeparation: 1000,
                // accentTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
                     rangeThumbShape: RoundRangeSliderThumbShape(
                     enabledThumbRadius: 100,
                     disabledThumbRadius: 100,),),
                        child: Slider(
                               min: 0.0,
                               max: 1000000.0,
                               value: slid,
                               divisions: 1000000,
                               label: (slid.toInt()).toString(),
                               onChanged: (val) {
                               setState(() {
                               slid = ((val).toInt()).toDouble();
                               chosenprice = (val).toInt();
                               print("yes $chosenprice");
                               print(slid);});},),
                      ),

                    Row(
                      children: <Widget>  [
                        Text("   Minimum Parking lot",style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor:  Color(0xFF005e6a),
                        inactiveTrackColor: Colors.blueGrey,
                        activeTrackColor: Color(0xFF005e6a),
                        thumbColor: Colors.black,
                        trackHeight: 5,
                        overlayColor: Colors.transparent,
                        minThumbSeparation: 1000,

                        // accentTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
                        rangeThumbShape: RoundRangeSliderThumbShape(

                          enabledThumbRadius: 100,
                          disabledThumbRadius: 100,),),
                      child: Slider(

                        min: 0.0,
                        max: 10000.0,
                        value: parkslid,
                        divisions: 10000,
                        label: (parkslid.toInt()).toString(),
                        onChanged: (val) {
                          setState(() {
                            parkslid = ((val).toInt()).toDouble();
                            chosenlot = (val).toInt();
                            print(parkslid);});},),
                    ),
                    Row(
                      children: <Widget>  [
                        Text("   Minimum Sitting Capacity",style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorColor:  Color(0xFF005e6a),
                        inactiveTrackColor: Colors.blueGrey,
                        activeTrackColor: Color(0xFF005e6a),
                        thumbColor: Colors.black,
                        trackHeight: 5,
                        overlayColor: Colors.transparent,
                        minThumbSeparation: 1000,

                        // accentTextTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
                        rangeThumbShape: RoundRangeSliderThumbShape(

                          enabledThumbRadius: 100,
                          disabledThumbRadius: 100,),),
                      child: Slider(

                        min: 0.0,
                        max: 20000.0,
                        value: sittingslid,
                        divisions: 10000,
                        label: (sittingslid.toInt()).toString(),
                        onChanged: (val) {
                          setState(() {
                            sittingslid = ((val).toInt()).toDouble();
                            chosensittingcap = (val).toInt();
                            print(sittingslid);});},),
                    ),
                    Container(
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {
                          makefilteredList();
                          Navigator.of(context).pop();
                        },
                       // onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Color(0xFF005e6a),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                    ),

                    /*Row(
                children: <Widget> [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: new Text('OK')
                  )
                ],
              ),*/
                    /* new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text('OK')
              )*/
                  ],
                );
              },
            ),
//            actions: <Widget>[
//
//            ],
          );
        }
    );
  }
  void makefilteredList()
  {
    List<conventionHall>filtered_list = new List();
    for(int i=0;i<AllHall.length;i++)
      {
        int f = 1;
        int cnt = 0;
        for(int j=0;j<8;j++)
          {
            if(j<7)
              {
                if(filter[j]==false) cnt++;
                if(AllHall[i].facility[j]=='0' && filter[j]==true) f = 0;
               // else if(AllHall[i].facility[j]=='1' && filter[j]==false) f = 0;
                if(cnt==7) f = 1;
              }
            else if(selectedRadio==2 && AllHall[i].facility[j]=='0') f = 0;

          }
        int val = int.parse(AllHall[i].mxprice);
        if(chosenprice!=-1 && val>chosenprice) f =0 ;
        val = int.parse(AllHall[i].parking);
        if(chosenlot!=-1 && val<chosenlot) f = 0;
        val = int.parse(AllHall[i].Sitting_cap);
        if(chosensittingcap!=-1 && val<chosensittingcap) f = 0;
        if(f==1) filtered_list.add(AllHall[i]);
      }

    setState(() {
      hallList.clear();
      SearchResultGenerator.globalHallList.clear();

      for(int i=0;i<filtered_list.length;i++)
        {
          hallList.add(filtered_list[i]);
          SearchResultGenerator.globalHallList.add(filtered_list[i]);
        }
    });
    return ;
  }


  List<dynamic> sortByPriceAscending( List<dynamic> list )
  {
    setState(() {
      hallList.sort((a, b) => a.mnprice.compareTo(b.mnprice));
    });

    return hallList;
  }
  List<dynamic> sortByPriceDescending( List<dynamic> list )
  {
    setState(() {
      hallList.sort((b, a) => a.mnprice.compareTo(b.mnprice));
    });

    return hallList;
  }

  List<dynamic> sortByParkingAscending( List<dynamic> list )
  {
    hallList.sort((a, b) => a.parking.compareTo(b.parking));

    return hallList;
  }

  List<dynamic> sortByParkingDescending( List<dynamic> list )
  {
    hallList.sort((b, a) => a.parking.compareTo(b.parking));

    return hallList;
  }

  List<dynamic> sortByNameAscending( List<dynamic> list )
  {
    setState(() {
      hallList.sort((a, b) => a.Name.compareTo(b.Name));
    });

    return hallList;
  }

  List<dynamic> sortByNameDescending( List<dynamic> list )
  {
    setState(() {
      hallList.sort((b, a) => a.Name.compareTo(b.Name));
    });

    return hallList;
  }

  void sortHandler( int value, context )
  {
    Navigator.pop(context);
    if( value==0 )
    {
      setState(() {
        hallList= sortByNameAscending(hallList);
      });
    }
    if( value==1 )
    {
      setState(() {
        hallList= sortByNameDescending(hallList);
      });
    }
    if( value==2 )
    {
      setState(() {
        hallList= sortByPriceAscending(hallList);
      });
    }
    if( value==3 )
    {
      setState(() {
        hallList= sortByPriceDescending(hallList);
      });
    }
    if( value==4 )
    {
      setState(() {
        hallList= sortByParkingAscending(hallList);
      });
    }
    if( value==5 )
    {
      setState(() {
        hallList= sortByParkingDescending(hallList);
      });
    }

    print("first e"+hallList[0].Name);
  }

  void showSortOptions()
  {
    showModalBottomSheet(
        context: context,
        builder: (context)
        {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text("Sort by name (Ascending)",),
                onTap: ()=> sortHandler(0,context),
              ),
              ListTile(
                title: Text("Sort by name (Descending)"),
                onTap: ()=> sortHandler(1,context),
              ),
              ListTile(
                title: Text("Sort by price (Ascending)"),
                onTap: ()=> sortHandler(2,context),
              ),
              ListTile(
                title: Text("Sort by price (Descending)"),
                onTap: ()=> sortHandler(3,context),
              ),
              ListTile(
                title: Text("Sort by parking space (Ascending)"),
                onTap: ()=> sortHandler(4,context),
              ),
              ListTile(
                title: Text("Sort by parking space (Descending)"),
                onTap: ()=> sortHandler(5,context),
              ),
            ],
          );
        }
    );
  }
}

