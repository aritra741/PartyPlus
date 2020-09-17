import 'package:flutter/material.dart';
import 'package:partyplus/constants/constants_for_login.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';
import 'modify_reservation.dart';

class RetrieveReservation extends StatefulWidget {
  @override
  _RetrieveReservationState createState() => _RetrieveReservationState();
}

class _RetrieveReservationState extends State<RetrieveReservation> {

  TextEditingController reservationID= new TextEditingController();
  int currentIndex= 1;
  int num_of_days= 3, check= 3;
  bool pressed= false;

  @override
  void dispose() {
    reservationID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PartyPlus",
        ),
        backgroundColor: Color(0xFF005e6a),
      ),
      body: SingleChildScrollView(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              decoration: kBoxDecorationStyleDiffColor,
              height: 60.0,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: reservationID,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.card_travel,
                    color: Colors.black,
                  ),
                  hintText: 'Enter reservation ID',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              width: 200,
              height: 50,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  setState(() {
                    pressed = true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ModifyReservation()));
                  });
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF005e6a),
                child: Text(
                  'RETRIEVE',
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
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              backgroundColor: Color(0xFF004b55)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              title: Text("Reservation"),
              backgroundColor: Color(0xFF004b55)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Login"),
              backgroundColor: Color(0xFF004b55)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              title: Text("Register"),
              backgroundColor: Color(0xFF004b55)
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            setState(() {
              currentIndex = 0;
            });
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreenBody()));
          }
          else if (index == 1) {
            setState(() {
              currentIndex = 1;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RetrieveReservation()),);
          }
          else if (index == 2) {
            setState(() {
              currentIndex = 2;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),);
          }
          else {
            setState(() {
              currentIndex = 3;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),);
          }
        },
      ),
    );
  }
}
