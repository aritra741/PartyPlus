import 'package:flutter/material.dart';
import 'package:partyplus/RetrieveUserReservation.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/screens/user_profile_update.dart';
import '../constants/constants_for_user_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {

    int currentIndex= 0;

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit * 10,
            width: kSpacingUnit * 10,
            margin: EdgeInsets.only(top: kSpacingUnit * 3),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: kSpacingUnit * 2.5,
//                    width: kSpacingUnit * 2.5,
                    child: Center(
                      heightFactor: kSpacingUnit * 1.5,
                      widthFactor: kSpacingUnit * 1.5,
                      child: Icon(
                        Icons.person,
                        color: kDarkPrimaryColor,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
//          SizedBox(height: kSpacingUnit * 2),
          Text(
            'Aritra Mazumder',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit * 0.5),
          Text(
            'Aritra741@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit * 2),
        ],
      ),
    );


    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
        SizedBox(width: kSpacingUnit * 3),
      ],
    );

    return Scaffold(
      body: Container(
        color: kLightPrimaryColor,
        child: Column(
          children: <Widget>[
            SizedBox(height: kSpacingUnit * 5),
            header,
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UserProfileUpdate()),);},
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: kLightSecondaryColor,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Edit personal information',
                              style: GoogleFonts.overpass(color: kDarkPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {},
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: kLightSecondaryColor,
                        child: Row(
                          children: <Widget>[
                            Icon(
                                Icons.card_travel
                            ),
                            SizedBox(
                              width: 20,
                            ),

                            GestureDetector(
                                onTap: () {
                                  //print("naam holo "+convention.Name);
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>RetrieveUserReservation()));
                                },
                                child : Text(
                                  'Modify/delete reservation',
                                  style: GoogleFonts.overpass(color: kDarkPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold ),
                                ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                                Icons.keyboard_arrow_right
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () {},
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: kLightSecondaryColor,
                        child: Row(
                          children: <Widget>[
                            Icon(
                                Icons.power_settings_new
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Logout',
                              style: GoogleFonts.overpass(color: kDarkPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                                Icons.keyboard_arrow_right
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: 0,
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

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreenBody()),);
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
}