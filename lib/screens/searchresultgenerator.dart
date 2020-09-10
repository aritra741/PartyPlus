import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'search_screen_body.dart';
import 'package:partyplus/providers/conventionHall.dart';
import 'package:partyplus/conventionHallDetails.dart';
/*class SearchResultGenerator extends StatelessWidget {
  String searchstring;
  SearchResultGenerator({this.searchstring});
  @override
  Widget build(BuildContext context) {
    print("eikhane paisi"+searchstring);
    return Scaffold(
      appBar: AppBar(
        title: Text("PartyPlus"),
        backgroundColor: Color(0xFF005e6a),
      ),
        body: Center(
          child: Text(
            searchstring,
          ),
        ),
    );


  }
  List<conventionHall> list = [];
  DatabaseReference ref = FirebaseDatabase.instance.reference().child("conventionHall");
  ref.once().then((DataSnapshot snap)
  {
    var KEYS = snap.value.keys;
  });
}*/
class SearchResultGenerator extends StatefulWidget {
  bool cbxval = false;
  String searchstring;
  SearchResultGenerator({this.searchstring});
  @override
  _SearchResultGeneratorState createState() => _SearchResultGeneratorState(searchstring);
}

class _SearchResultGeneratorState extends State<SearchResultGenerator> {
  String UserDemandFacility = "0000000";
  double slid = 1000000.0;
  double parkslid = 0.0;
  int selectedRadio;
  bool cbxval = false;
  String searchstring;
  _SearchResultGeneratorState(this.searchstring);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*body: Center(
        child: Text(
          searchstring,
        ),
      ),*/
      body: new Container(
        child: list.length==0?new Text("No result found") : new Column(
          children: <Widget>[
        new Expanded(child:
          ListView.builder(
              itemCount: list.length,
              itemBuilder: (_,index){
                return conventionUI(list[index].image, list[index].Name, list[index].City, list[index].street,list[index]);
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
  List<conventionHall> list = [];
  conventionHall test = new conventionHall("Sylhet", "cc", "Shubidh Bazar", "Khan's Palace", "1", "1110111", "1234", "1234", "1335", "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/khan.jpg?alt=media&token=267e9cc7-6646-4df0-bceb-a99e1b88360f", 12.3, 12.55);
  conventionHall test2 = new conventionHall("Chittagong", "cc", "Main Road", "King of Chittagong", "1", "1110111", "1234", "1234", "1335", "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/king%20of%20chittagong.jpg?alt=media&token=003e5c26-53bc-47b8-ab29-654cb9f97028", 12.3, 12.55);
  //list.add(test);

  @override
  void initState(){
    super.initState();
    selectedRadio = 0;
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("conventionHall");
    list.add(test);
    list.add(test2);
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
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
          Navigator.push(context,MaterialPageRoute(builder: (context)=>conventionHallDetails(convention: convention)));
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
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    city,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(height: 10.0,),
              new Image.network(image,fit: BoxFit.cover),
              SizedBox(height: 10.0,),
              new Text(
                street,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
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
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              cbxval = value;
                            });
                          },
                        ),
                        Text("AC"),
                        Checkbox(
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              cbxval = value;
                            });
                          },
                        ),
                        Text("Wifi"),
                        Checkbox(
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              cbxval = value;
                            });
                          },
                        ),
                        Text("CC Camera"),
                      ],
                    ),

                    Row(
                      children: <Widget> [
                        Checkbox(
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              cbxval = value;
                            });
                          },
                        ),
                        Text("Firework Place"),
                        Checkbox(
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              cbxval = value;
                            });
                          },
                        ),
                        Text("Photoshoot Area"),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: cbxval,
                          onChanged: (bool value){
                            setState(() {
                              print(value);
                              cbxval = value;
                            });
                          },
                        ),
                        Text("Fire Control"),
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
                                selectedRadio = val;
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
                                selectedRadio = val;
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
                               print(slid);});},),
                      ),

                    Row(
                      children: <Widget>  [
                        Text("   Parking lot",style: TextStyle(color: Colors.black,
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
                            print(parkslid);});},),
                    ),
                    Container(
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () => Navigator.of(context).pop(),
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


  List<dynamic> sortByPriceAscending( List<dynamic> list )
  {
    setState(() {
      list.sort((a, b) => a.mnprice.compareTo(b.mnprice));
    });

    return list;
  }
  List<dynamic> sortByPriceDescending( List<dynamic> list )
  {
    setState(() {
      list.sort((b, a) => a.mnprice.compareTo(b.mnprice));
    });

    return list;
  }

  List<dynamic> sortByParkingAscending( List<dynamic> list )
  {
    list.sort((a, b) => a.parking.compareTo(b.parking));

    return list;
  }

  List<dynamic> sortByParkingDescending( List<dynamic> list )
  {
    list.sort((b, a) => a.parking.compareTo(b.parking));

    return list;
  }

  List<dynamic> sortByNameAscending( List<dynamic> list )
  {
    setState(() {
      list.sort((a, b) => a.Name.compareTo(b.Name));
    });

    return list;
  }

  List<dynamic> sortByNameDescending( List<dynamic> list )
  {
    setState(() {
      list.sort((b, a) => a.Name.compareTo(b.Name));
    });

    return list;
  }

  void sortHandler( int value, context )
  {
    Navigator.pop(context);
    if( value==0 )
    {
      setState(() {
        list= sortByNameAscending(list);
      });
    }
    if( value==1 )
    {
      setState(() {
        list= sortByNameDescending(list);
      });
    }
    if( value==2 )
    {
      setState(() {
        list= sortByPriceAscending(list);
      });
    }
    if( value==3 )
    {
      setState(() {
        list= sortByPriceDescending(list);
      });
    }
    if( value==4 )
    {
      setState(() {
        list= sortByParkingAscending(list);
      });
    }
    if( value==5 )
    {
      setState(() {
        list= sortByParkingDescending(list);
      });
    }

    print("first e"+list[0].Name);
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

