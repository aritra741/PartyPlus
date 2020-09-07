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
        child: list.length==0?new Text("No result found") : new ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index){
          return conventionUI(list[index].image, list[index].Name, list[index].City, list[index].street,list[index]);
        }
      ),
      ),
    );
  }
  List<conventionHall> list = [];
  conventionHall test = new conventionHall("Sylhet", "cc", "Shubidh Bazar", "Khan's Palace", "1", "1110111", "1234", "1234", "1335", "https://firebasestorage.googleapis.com/v0/b/fireapp-3d1c4.appspot.com/o/khan.jpg?alt=media&token=267e9cc7-6646-4df0-bceb-a99e1b88360f", 12.3, 12.55);
  //list.add(test);

  @override
  void initState(){
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.reference().child("conventionHall");
    list.add(test);
    if(ref==null) print('ha eta null');
    ref.once().then((DataSnapshot snap)
    {
      //list.add(test);
      var KEYS = snap.value.keys;
      var DATA = snap.value;
    //  list.clear();
      for(var individualkey in KEYS)
        {
          conventionHall con = new conventionHall
            (
            DATA[individualkey]['City'],
            DATA[individualkey]['District'],
            DATA[individualkey]['Street Name'],
            DATA[individualkey]['Name'],
            DATA[individualkey]['Id'],
            DATA[individualkey]['facility'],
            DATA[individualkey]['parking'],
            DATA[individualkey]['mnprice'],
            DATA[individualkey]['mxprice'],
            DATA[individualkey]['image'],
            DATA[individualkey]['Lat'],
            DATA[individualkey]['Long'],

          );
          print(con.Name);
         // if(con.Name.contains("k"))
           list.add(con);
          //else print("yes");
        }
      setState(() {
        print('Length: $list.length');
      });
    });
  }

  Widget conventionUI(String image,String name,String city,String street,conventionHall convention)
  {
    return new Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),

      child: new InkWell(
        onTap: () {
          print("naam holo "+convention.Name);
//          Navigator.push(context,MaterialPageRoute(builder: (context)=>conventionHallDetails(convention: convention)));
          showFilterDialog();
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
            title: new Text('Choose to Filter'),
           // content: new Text('Please enter correct Username and Password'),
            actions: <Widget>[
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
                  Text("CC"),
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
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: new Text('OK')
                  )
                ],
              ),
             /* new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new Text('OK')
              )*/
            ],
          );
        }
    );
  }

  List<dynamic> sortByPriceAscending( List<dynamic> list )
  {
    list.sort((a, b) => a.mnprice.compareTo(b.mnprice));

    return list;
  }
  List<dynamic> sortByPriceDescending( List<dynamic> list )
  {
    list.sort((b, a) => a.mnprice.compareTo(b.mnprice));

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
    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  List<dynamic> sortByNameDescending( List<dynamic> list )
  {
    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  void sortHandler( int value )
  {
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
  }
}

