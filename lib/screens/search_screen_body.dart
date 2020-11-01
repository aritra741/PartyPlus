import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partyplus/providers/User.dart';
import 'package:partyplus/screens/retrieve_reservation.dart';
import 'package:partyplus/screens/search_result_list_map.dart';
import 'package:partyplus/widgets/navigation_drawer.dart';
import 'register_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partyplus/db_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
//import 'package:flutterModule/navigation_drawer.dart';
import 'searchresultgenerator.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SearchScreenBody extends StatefulWidget {
  static int val= 5;
  static User authenticatedUser;
  @override
  _SearchScreenBodyState createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  String showDay, showMonth, showYear;
  int currentIndex= 0;
  DateTime selectedDate= DateTime.now();
  String searchString, dayString= "1";
  int dayGroup= 0;
  var searchText= TextEditingController();
  //String value = searchText.text;
  static int numberOfDays= 2;
  bool dayOneMorning= false, dayOneEvening= false, dayOneNight= false;
  bool dayTwoMorning= false, dayTwoEvening= false, dayTwoNight= false;
  bool dayThreeMorning= false, dayThreeEvening= false, dayThreeNight= false;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  var authHandler = new Auth();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(now);
  static DateTime secDate; //= new DateTime(now.year, now.month, selectedDate.day+1);
  static DateFormat formatter2 ;//= DateFormat('dd-MM-yyyy');
  String formatted2; //= formatter2.format(secDate);
  static DateTime thDate;//= new DateTime(secDate.year, secDate.month, secDate.day+1);
  static DateFormat formatter3 ;//= DateFormat('dd-MM-yyyy');
  String formatted3; //= formatter3.format(thDate);
  String userToken;
  static User authenticatedUser;
  String whichconventionimg = "";
  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }


  List imgList = [
    'https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/khan.jpg?alt=media&token=267e9cc7-6646-4df0-bceb-a99e1b88360f',
    'https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/amanullah.jpg?alt=media&token=b7772da6-42aa-4d06-9552-582ff926882d',
    'https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/king%20of%20chittagong.jpg?alt=media&token=003e5c26-53bc-47b8-ab29-654cb9f97028',

    'https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/Hall24.jpg?alt=media&token=73e3786f-9a37-45f7-bd66-7dc3ff212c4d',
   // 'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }


  Future<String> checkIfLoggedIn () async
  {
    final SharedPreferences userPref= await SharedPreferences.getInstance();
    userToken= userPref.getString('token');

    return userToken;
  }

  @override
  void initState()
  {
    checkIfLoggedIn().then( (token)=>{
      if(token!=null)
        {
          authenticatedUser= User(token),
          print("token holo "+token.toString())
        }
      else
        {
          print("hoynai")
        }
    } );
    super.initState();
  }


  Future speedup() async
  {

      var match = {
        "what" : "sylhet"
      };

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

    }

    Future <List> getSuggestions(String suggestString) async{
      
      List suggestionsList= new List();
    
      var match = {
        "name" : suggestString
      };

      print( json.encode(match) );

      // print(SearchScreenBody.numberOfDays);
      final String apiurl = "http://partyplusapi.herokuapp.com/suggestion";
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

      var jsonlist = jsonDecode(response.body) as List;
      jsonlist.forEach((e) {
        suggestionsList.add(e);
      });

      print(suggestionsList);
      return suggestionsList;
    }
    
  @override
  Widget build(BuildContext context) {
    secDate = new DateTime(selectedDate.year, selectedDate.month, selectedDate.day+1);
    formatter2 = DateFormat('dd-MM-yyyy');
    formatted2 = formatter2.format(secDate);
    thDate = new DateTime(secDate.year, secDate.month, secDate.day+1);
    formatter3 = DateFormat('dd-MM-yyyy');
    formatted3 = formatter3.format(thDate);
    DateTime now = DateTime.now();
    showDay = DateFormat('EEEE').format(now);
    showMonth = DateFormat('MMMM').format(now);
    showYear = DateFormat('y').format(now);

    print("user holo");
    print(authenticatedUser);

    dayOneShift= List<bool>();
    dayTwoShift= List<bool>();
    dayThreeShift= List<bool>();
    // speedup();

    for( int i=0;i<3;i++ )
      {
        dayOneShift.add(false);
        dayTwoShift.add(false);
        dayThreeShift.add(false);
      }

    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity,50),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white12,
            iconTheme: new IconThemeData(color: Color(0xFF005e6a)),
            centerTitle: true,
            title: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 45,),
                  Text(
                    "Party",
                    style: GoogleFonts.overpass(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w200 ),
                  ),
                  Text(
                    "Plus",
                    style: GoogleFonts.overpass(color: Color(0xFF008A8C), fontSize: 32, fontWeight: FontWeight.bold ),
                  )
                ],
              ),
            ),
          ),
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[


              searchScreenTop(),
              Container(
                child: CarouselSlider(
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index) {
                    setState(() {
                      print("here index $index");
                      if(index==0)  whichconventionimg = "Khan's Palace Convention Hall";
                      else if(index==1) whichconventionimg = "Amanullah Convention Hall";
                      else if(index==2) whichconventionimg = "King of Chittagong";
                      else whichconventionimg = "Hall 24";
                    });
                  },
                  items: imgList.map(
                        (url) {
                      return Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(children: <Widget>[
                            Image.network(url, fit: BoxFit.cover, width: 1000.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                child: Text(
                                  whichconventionimg,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          /*child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            width: 1000.0,
                          ),*/
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),

            //Container(),
           /* Expanded(
                child: searchScreenTop(),
              ),*/
              SizedBox(height: 30.0),

              Container(
                  height: MediaQuery.of(context).size.height * 0.82,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(14, 0),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: new Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24),
                              onPressed: () => _selectDate(context),
                              child: reserVationDateSelector(
                                  "Number of days", DateTime.now()),
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int selectedRadio = dayGroup;
                                    return AlertDialog(
                                      title: Text("Number of days"),
                                      actions: <Widget>[
                                        new FlatButton(onPressed: ()
                                            {
                                              setNumberOfDays();
                                              Navigator.of(context, rootNavigator: true)
                                                  .pop();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 50,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF005e6a),
                                              ),
                                              child: Text("ok", style: TextStyle(fontSize: 22, color: Colors.white)),
                                            )
                                        )
                                      ],
                                      content: StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text("1 day"),
                                                leading: Radio<int>(
                                                  value: 0,
                                                  groupValue: selectedRadio,
                                                  onChanged: (int value) {
                                                    setState(() {selectedRadio = value;dayGroup= value;dayString= (dayGroup+1).toString();});
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: Text("2 days"),
                                                leading: Radio<int>(
                                                  value: 1,
                                                  groupValue: selectedRadio,
                                                  onChanged: (int value) {
                                                    setState(() {selectedRadio = value;dayGroup= value;dayString= (dayGroup+1).toString();});
                                                  },
                                                ),
                                              ),
                                              ListTile(
                                                title: Text("3 days"),
                                                leading: Radio<int>(
                                                  value: 2,
                                                  groupValue: selectedRadio,
                                                  onChanged: (int value) {
                                                    setState(() {selectedRadio = value;dayGroup= value;(dayGroup+1).toString();});
                                                  },
                                                ),
                                              ),

                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: numberOfDaysSelector(),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: true,
                        child: Container(
                          height: 50,
                          // padding: EdgeInsets.only(top:10),
                          child: Container(
//                            color: Color(0xFFF4F0DB),
//                            elevation: 20,
                              height: 30,
                            child: ListView(
                              // padding: EdgeInsets.only(top: 10, ),
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      " "+formatted,
                                      style: GoogleFonts.overpass(fontSize: 20, color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 95,
                                    ),
                                    InkWell(
                                      onTap: ()
                                      {
                                        showDialog<void>( context: context,
                                            builder: (BuildContext context){
                                              bool _morning= dayOneMorning;
                                              bool _evening= dayOneEvening;
                                              bool _night= dayOneNight;

                                              return AlertDialog(
                                                title: Text("Shift(s)"),
                                                actions: <Widget>[
                                                  new FlatButton(onPressed: ()
                                                  {
                                                    setNumberOfDays();
                                                    Navigator.of(context, rootNavigator: true)
                                                        .pop();
                                                  },
                                                      child: Container(
                                                        height: 40,
                                                        width: 50,
                                                        padding: EdgeInsets.only(left: 11, top: 5),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF005e6a),
                                                        ),
                                                        child: Text("ok", style: TextStyle(fontSize: 22, color: Colors.white)),
                                                      )
                                                  )
                                                ],
                                                content: StatefulBuilder(
                                                  builder: (BuildContext context, StateSetter setState) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        CheckboxListTile(
                                                          value: _morning,
                                                          title: Text("Morning (9am - 3pm)"),
                                                          onChanged: (value){
                                                            setState( ()
                                                            {
                                                              _morning= value;
                                                              getShiftInfoForDayOne(_morning, _evening, _night);
                                                            });
                                                          },
                                                        ),
                                                       /* CheckboxListTile(
                                                          value: _evening,
                                                          title: Text("Noon"),
                                                          onChanged: (value)
                                                          {
                                                            setState( ()
                                                            {
                                                              _evening= value;
                                                              getShiftInfoForDayOne(_morning, _evening, _night);
                                                            });
                                                          },
                                                        ),*/
                                                        CheckboxListTile(
                                                          value: _night,
                                                          title: Text("Evening (4pm - 11pm)"),
                                                          onChanged: (value)
                                                          {
                                                            setState( ()
                                                            {
                                                              _night= value;
                                                              getShiftInfoForDayOne(_morning, _evening, _night);
                                                            });
                                                          },
                                                        ),

                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            } );
                                      },
                                      child: Text(
                                        "Select shift",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.teal,
                                            decoration: TextDecoration.underline
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Visibility(
                                  visible: true,
                                  child: Text(
                                      (dayOneMorning?"     Morning":"")+(dayOneEvening?"     Noon":"")+(dayOneNight?"      Evening":""),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF005e6a)
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Visibility(
                        visible: dayGroup>=1,
                        child: Container(
                          height: 50,
                          // padding: EdgeInsets.only(top:10),
                          child: SizedBox(
//                              color: Color(0xFFF4F0DB),
//                              elevation: 20,
                              height: 30,
                              child: ListView(
                                // padding: EdgeInsets.only(top: 10, ),
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        " "+formatted2,
                                        style: GoogleFonts.overpass(fontSize: 20, color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      InkWell(
                                        onTap: ()
                                        {
                                          showDialog<void>( context: context,
                                              builder: (BuildContext context){
                                                bool _morning= dayTwoMorning;
                                                bool _evening= dayTwoEvening;
                                                bool _night= dayTwoNight;

                                                return AlertDialog(
                                                  title: Text("Shift(s)"),
                                                  actions: <Widget>[
                                                    new FlatButton(onPressed: ()
                                                    {
                                                      setNumberOfDays();
                                                      Navigator.of(context, rootNavigator: true)
                                                          .pop();
                                                    },
                                                        child: Container(
                                                          height: 40,
                                                          width: 50,
                                                          padding: EdgeInsets.only(left: 11, top: 5),
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFF005e6a),
                                                          ),
                                                          child: Text("ok", style: TextStyle(fontSize: 22, color: Colors.white)),
                                                        )
                                                    )
                                                  ],
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          CheckboxListTile(
                                                            value: _morning,
                                                            title: Text("Morning (9am - 3pm)"),
                                                            onChanged: (value){
                                                              setState( ()
                                                              {
                                                                _morning= value;
                                                                getShiftInfoForDayTwo(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),
                                                          /*CheckboxListTile(
                                                            value: _evening,
                                                            title: Text("Noon"),
                                                            onChanged: (value)
                                                            {
                                                              setState( ()
                                                              {
                                                                _evening= value;
                                                                getShiftInfoForDayTwo(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),*/
                                                          CheckboxListTile(
                                                            value: _night,
                                                            title: Text("Evening (4pm - 11pm)"),
                                                            onChanged: (value)
                                                            {
                                                              setState( ()
                                                              {
                                                                _night= value;
                                                                getShiftInfoForDayTwo(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),

                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              } );
                                        },
                                        child: Text(
                                          "Select shift",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.teal,
                                              decoration: TextDecoration.underline
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Text(
                                      (dayTwoMorning?"     Morning":"")+(dayTwoEvening?"     Noon":"")+(dayTwoNight?"      Evening":""),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF005e6a)
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dayGroup>=1,
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Visibility(
                        visible: dayGroup>=2,
                        child: Container(
                          height: 50,
                          // padding: EdgeInsets.only(top:10),
                          child: Container(
//                              color: Color(0xFFF4F0DB),
//                              elevation: 20,
                              height: 20,
                              child: ListView(
                                // padding: EdgeInsets.only(top: 10, ),
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        " "+formatted3,
                                        style: GoogleFonts.overpass(fontSize: 20, color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 95,
                                      ),
                                      InkWell(
                                        onTap: ()
                                        {
                                          showDialog<void>( context: context,
                                              builder: (BuildContext context){
                                                bool _morning= dayThreeMorning;
                                                bool _evening= dayThreeEvening;
                                                bool _night= dayThreeNight;

                                                return AlertDialog(
                                                  title: Text("Shift(s)"),
                                                  actions: <Widget>[
                                                    new FlatButton(onPressed: ()
                                                    {
                                                      setNumberOfDays();
                                                      Navigator.of(context, rootNavigator: true)
                                                          .pop();
                                                    },
                                                        child: Container(
                                                          height: 40,
                                                          width: 50,
                                                          padding: EdgeInsets.only(left: 11, top: 5),
                                                          decoration: BoxDecoration(
                                                            color: Color(0xFF005e6a),
                                                          ),
                                                          child: Text("ok", style: TextStyle(fontSize: 22, color: Colors.white)),
                                                        )
                                                    )
                                                  ],
                                                  content: StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: <Widget>[
                                                          CheckboxListTile(
                                                            value: _morning,
                                                            title: Text("Morning (9am - 3pm)"),
                                                            onChanged: (value){
                                                              setState( ()
                                                              {
                                                                _morning= value;
                                                                getShiftInfoForDayThree(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),
                                                          /*CheckboxListTile(
                                                            value: _evening,
                                                            title: Text("Noon"),
                                                            onChanged: (value)
                                                            {
                                                              setState( ()
                                                              {
                                                                _evening= value;
                                                                getShiftInfoForDayThree(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),*/
                                                          CheckboxListTile(
                                                            value: _night,
                                                            title: Text("Evening (4pm - 11pm)"),
                                                            onChanged: (value)
                                                            {
                                                              setState( ()
                                                              {
                                                                _night= value;
                                                                getShiftInfoForDayThree(_morning, _evening, _night);
                                                              });
                                                            },
                                                          ),

                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              } );
                                        },
                                        child: Text(
                                          "Select shift",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.teal,
                                              decoration: TextDecoration.underline
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: Text(
                                      (dayThreeMorning?"     Morning":"")+(dayThreeEvening?"     Noon":"")+(dayThreeNight?"      Evening":""),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF005e6a)
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                      Visibility(
                        visible: dayGroup>=2,
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: kDefaultPadding),
                        width: 200,
                        height: 50,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            print("daygroup "+dayString);
                            searchQuery();
                        //    Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchResultListMap()));
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(0xFF005e6a),
                          child: Text(
                            'SEARCH',
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
                  )
              ),
            ],

          ),
        ),
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Color( 0xFF004b55 ),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.white,
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                backgroundColor: Color( 0xFF004b55 )
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                title: Text("Reservation"),
                backgroundColor: Color( 0xFF004b55 )
            ),
            if(SearchScreenBody.authenticatedUser==null)
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Login"),
                  backgroundColor: Color( 0xFF004b55 )
              ),
            if(SearchScreenBody.authenticatedUser==null)
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_add),
                  title: Text("Register"),
                  backgroundColor: Color( 0xFF004b55 )
              ),
          ],
          onTap: (index){
            if( index==0 ){
              setState(() {
                currentIndex= 0;
              });
            }
            else if( index==1 )
            {
              // setState(() {
              //   currentIndex= 1;
              // });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RetrieveReservation()),);
            }
            else if( index==2 )
            {
              // setState(() {
              //   currentIndex= 2;
              // });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),);

            }
            else
            {
              // setState(() {
              //   currentIndex= 3;
              // });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),);
            }
          },
        ),
      ),
     /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              backgroundColor: Color( 0xFF004b55 )
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              title: Text("Reservation"),
              backgroundColor: Color( 0xFF004b55 )
          ),
          if(1==0)
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Login"),
              backgroundColor: Color( 0xFF004b55 )
          ),
          if(1==0)
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              title: Text("Register"),
              backgroundColor: Color( 0xFF004b55 )
          ),
        ],
        onTap: (index){
          if( index==0 ){
            setState(() {
              currentIndex= 0;
            });
          }
          else if( index==1 )
          {
            // setState(() {
            //   currentIndex= 1;
            // });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RetrieveReservation()),);
            }
          else if( index==2 )
          {
            // setState(() {
            //   currentIndex= 2;
            // });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),);

          }
          else
          {
            // setState(() {
            //   currentIndex= 3;
            // });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),);
          }
        },
      ),*/
    );
  }

  Widget reserVationDateSelector(String textToShow, DateTime dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Reservation Date",
          style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Text(
              selectedDate.day.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 40),
            ),
//            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('MMMM').format(selectedDate) + ' ',
                  style: GoogleFonts.overpass(fontSize: 18),
                ),
                Text(
                  DateFormat('EEEE').format(selectedDate),
                  style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
                )
              ],
            )
          ],
        )
      ],
    );
  }

  Widget numberOfDaysSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Number of days",
          textAlign: TextAlign.center,
          style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          dayString,
          style: GoogleFonts.overpass(fontSize: 40),
        ),
      ],
    );
  }

  Widget searchScreenTop()
  {
    double size= MediaQuery.of(context).size.height;
    double screenHeight= MediaQuery.of(context).size.height;
    double screenwidth= MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding, top: kDefaultPadding * .25),
        height: size*0.15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Spacer(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(10, 10),
                    blurRadius: 50,
                    color: Colors.black26.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: screenwidth*0.7,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: searchText,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Destination, property or address",
                          hintStyle: TextStyle(
                            color: Color(0xFF003333)
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none
                        )
                      ),
                      suggestionsCallback: (pattern) async{
                        return await getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion){
                        print(suggestion);
                        return ListTile(
                          leading: (suggestion['type']=='location')?Icon(Icons.location_on,
                            color: Color(0xFFEA4335),):Icon(Icons.home,
                            color: Colors.blue,),
                          title: Text(suggestion['name']),
                        );
                      },
                      onSuggestionSelected: (suggestion){
                        setState(() {
                          searchString= suggestion['name'].toString();
                          searchText.text= searchString;
                        });
                        print("selected item "+searchString);
                      },
                    ),
                  ),
                  SvgPicture.asset("assets/icons/search.svg"),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void setNumberOfDays()
  {
    setState(() {
      dayString= (dayGroup+1).toString();
    });
  }

  void searchQuery()
  {
    String searchString= searchText.text;
    print(searchString);
    dayOneShift[0]= dayOneMorning;
    dayOneShift[1]= dayOneEvening;
    dayOneShift[2]= dayOneNight;
    dayTwoShift[0]= dayTwoMorning;
    dayTwoShift[1]= dayTwoEvening;
    dayTwoShift[2]= dayTwoNight;
    dayThreeShift[0]= dayThreeMorning;
    dayThreeShift[1]= dayThreeEvening;
    dayThreeShift[2]= dayThreeNight;
    int f = 1;
    int day = int.parse(dayString);
    if(day>=1 &&dayOneShift[0]==false && dayOneShift[1]== false && dayOneShift[2]==false ) f = 0;
    if(day>=2 &&dayTwoShift[0]==false && dayTwoShift[1]== false && dayTwoShift[2]==false ) f = 0;
    if(day>=3 &&dayThreeShift[0]==false && dayThreeShift[1]== false && dayThreeShift[2]==false ) f = 0;
    for(int i=0;i<3;i++)
    {
      print(dayOneShift[i]);
      print(dayTwoShift[i]);
      print(dayThreeShift[i]);
    }
    if(f==0 && searchString.length==0)
      {
        Fluttertoast.showToast(
            msg: "Please add shift and city or address",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1,
        );
      }
    else if(f==0)
      {
        Fluttertoast.showToast(
          msg: "Please add shift",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      }
    else if(searchString.length==0)
      {
        Fluttertoast.showToast(
          msg: "Please add city or address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      }
    else
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchResultListMap(searchstring: searchString,dayString:dayString,selectedDate:selectedDate,secDate:secDate,thDate:thDate,dayOneShift:dayOneShift,dayTwoShift: dayTwoShift, dayThreeShift: dayThreeShift)));
   // Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchResultGenerator(searchstring: searchString)),);
  }

  void getShiftInfoForDayOne( bool morning, bool evening, bool night )
  {
    setState(() {
      dayOneMorning= morning;
      dayOneEvening= evening;
      dayOneNight= night;
      dayOneShift[0]= morning;
      dayOneShift[1]= evening;
      dayOneShift[2]= night;
    });
  }
  void getShiftInfoForDayTwo( bool morning, bool evening, bool night )
  {
    setState(() {
      dayTwoMorning= morning;
      dayTwoEvening= evening;
      dayTwoNight= night;
      dayTwoShift[0]= morning;
      dayTwoShift[1]= evening;
      dayTwoShift[2]= night;
    });
  }
  void getShiftInfoForDayThree( bool morning, bool evening, bool night )
  {
    setState(() {
      dayThreeMorning= morning;
      dayThreeEvening= evening;
      dayThreeNight= night;
      dayThreeShift[0]= morning;
      dayThreeShift[1]= evening;
      dayThreeShift[2]= night;
    });
  }

}
