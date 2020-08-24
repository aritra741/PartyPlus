import 'package:flutter/material.dart';
import 'package:partyplus/login_screen.dart';
import 'package:partyplus/navigation_drawer.dart';
import 'package:partyplus/register_screen.dart';
import 'package:partyplus/search_screen_top.dart';
import 'constants_for_search_screen_top.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'search_screen_top.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutterModule/utilities/constants_for_search_screen_body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
//import 'package:flutterModule/navigation_drawer.dart';
import 'searchresultgenerator.dart';

class SearchScreenBody extends StatefulWidget {
  @override
  _SearchScreenBodyState createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  String showDay, showMonth, showYear;
  int currentIndex= 0;
  DateTime selectedDate= DateTime.now();
  TextEditingController searchText= TextEditingController();

  var authHandler = new Auth();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    showDay = DateFormat('EEEE').format(now);
    showMonth = DateFormat('MMMM').format(now);
    showYear = DateFormat('y').format(now);
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white12,
        iconTheme: new IconThemeData(color: Color(0xFF005e6a)),
      ),
      drawer: NavigationDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SearchScreenTop(MediaQuery.of(context).size.height),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(14, 0),
                        blurRadius: 12,
                      ),
                    ],
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(
                            MediaQuery.of(context).size.width * 2, 100)),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
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
                              onPressed: () {},
                              child: numberOfDaysSelector(),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.black26,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: kDefaultPadding*3),
                        width: 200,
                        height: 50,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchResultGenerator()),
                            );
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
                      )
                    ],
                  )
              ),
            ],

          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Login"),
              backgroundColor: Color( 0xFF004b55 )
          ),
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
            setState(() {
              currentIndex= 1;
            });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),);
          }
          else if( index==2 )
          {
            setState(() {
              currentIndex= 2;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),);

          }
          else
          {
            setState(() {
              currentIndex= 3;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),);
          }
        },
      ),
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
              dateTime.day.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 48),
            ),
//            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  showMonth + ' ' + showYear,
                  style: GoogleFonts.overpass(fontSize: 16),
                ),
                Text(
                  showDay,
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
        Text(
          "1",
          style: GoogleFonts.overpass(fontSize: 48),
        ),
      ],
    );
  }

  Widget searchScreenTop( double size )
  {
    double screenHeight= MediaQuery.of(context).size.height;
    double screenwidth= MediaQuery.of(context).size.width;
    return new Scaffold(
      body: new Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5, top: kDefaultPadding * 3),
        height: size*0.2+27,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
            Spacer(),
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
                    child: TextField(
                      controller: searchText,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Destination, property or address",
                        hintStyle: TextStyle(
                          color: Color(0xFF003333),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/search.svg"),
                ],
              ),
            ),
          ],
        ),
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
}
