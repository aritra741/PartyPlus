import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:partyplus/screens/retrieve_reservation.dart';
import 'login_screen.dart';
import 'search_screen_body.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants/constants_for_login.dart';
import '../providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _rememberMe = false;
  int currentIndex= 3;
  bool _inAsyncCall= false;
  var userEmail= TextEditingController();
  var userPassword= TextEditingController();
  var userPhone= TextEditingController();
  var userName= TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
  }

  Future <String> handleRegistration( String email, String password ) async {

    var userInfo = {
      "email" : email,
      "password": password
    };

    // print( json.encode(match) );

    // print("HYSE??");
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/register";
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
          body: userInfo,
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

    final SharedPreferences userData= await SharedPreferences.getInstance();
    userData.setString('token', response.body);

    return response.body;
  }

  Widget _buildFirstNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: userName,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your full name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLastNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Last Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your last name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: userPhone,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.local_phone,
                color: Colors.white,
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: userEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: userPassword,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegitserBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          setState( (){
            _inAsyncCall= true;
          } );
            handleRegistration(userEmail.text, userPassword.text)
                .then( (token) =>{
                  setState( (){
                    _inAsyncCall= false;
                  } ),

              if( token.contains("email") || token.contains("password") )
                {
                  Fluttertoast.showToast(
                      msg: "Something went wrong. Please check your credentials.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 5)
                }
              else
                {
                  Fluttertoast.showToast(
                      msg: "Registration Successful",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreenBody()),),

                },

                print("token ta holo "+ token.toString())
            } );
        } ,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'REGISTER',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF005A5A),
                        Color(0xFF004D4D),
                        Color(0xFF004040),
                        Color(0xFF003333),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 60.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        _buildFirstNameTF(),
                        SizedBox(height: 8.0),
                        _buildEmailTF(),
                        SizedBox(height: 8.0),
                        _buildPhoneNumberTF(),
                        SizedBox(
                          height: 8.0,
                        ),
                        _buildPasswordTF(),
                        _buildRegitserBtn(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        inAsyncCall: _inAsyncCall,
        progressIndicator: CircularProgressIndicator(),
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
            // setState(() {
            //   currentIndex= 0;
            // });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreenBody()),);
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
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => RegisterScreen()),);
          }
        },
      ),
    );
  }

  void writeUserData(String uid)
  {
    String userFullName= userName.text;
    var nameList= userFullName.split(' ');

    String firstName='';

    for( int i=0;i<nameList.length-1;i++ )
    {
        if(i>0)
          firstName+= ' ';
        firstName+= nameList[i];
    }
  }
}