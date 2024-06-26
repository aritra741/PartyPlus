import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:partyplus/providers/User.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/retrieve_reservation.dart';
//import 'package:flutterModule/register_screen.dart';
import 'search_screen_body.dart';
import '../providers/auth.dart';
import '../constants/constants_for_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  int currentIndex= 2;
  bool _inAsyncCall= false;
  var authHandler= new Auth();
  var userEmail= TextEditingController();
  var userpassword= TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userEmail.dispose();
    userpassword.dispose();
    super.dispose();
  }

  Future <String> resetPassword( String email ) async
  {
    var userInfo = {
      "email" : email
    };

    // print( json.encode(match) );

    // print("HYSE??");
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/reset";
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

    return response.body;
  }

  Future <String> handleLogin( String email, String password ) async {

    var userInfo = {
      "email" : email,
      "password": password
    };

    // print( json.encode(match) );

    // print("HYSE??");
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/login";
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

    if( !(response.body.toString().contains('error')) )
      userData.setString('token', response.body);

    print("eikhane respons "+response.body);
    return response.body;
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
            controller: userpassword,
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

  createAlert(BuildContext context)
  {
    TextEditingController email = TextEditingController();
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text('Email'),
        content: TextField(
          controller: email,
        ),
        actions: [
          MaterialButton(
              elevation: 5.0,
            child: Text('Submit'),
            onPressed: (){
               resetPassword(email.text.toString()).then( (val)=>{
                Fluttertoast.showToast(msg: "Please check your email",
                   toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                   timeInSecForIosWeb: 3,
                )
               } );
               Navigator.of(context, rootNavigator: true)
                   .pop();
            },
          )
        ],
      );
    });
  }
  Widget _buildForgotPasswordBtn(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => {


        createAlert(context),
          // resetPassword(emailTaEikhane).then( (val)=>{
          //   Fluttertoast.showToast(msg: "Please check your email",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 3,
          //   )
          // } )
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          setState(() {
            _inAsyncCall= true;
          });
          handleLogin(userEmail.text, userpassword.text)
              .then((val) {
                setState(() {
                  _inAsyncCall= false;
                });

                if(val.contains("error"))
                  {
                    Fluttertoast.showToast(
                        msg: "Something went wrong. Please check your credentials",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3);
                  }
                else
                  {
                    SearchScreenBody.authenticatedUser= User( val.toString() );
                    print("response holo "+val.toString());

                    Fluttertoast.showToast(
                        msg: "Login Successful",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreenBody()),);

                  }

            }).catchError((e) =>  Fluttertoast.showToast(
            msg: "Something went wrong. Please Try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
          ));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(context),
                        _buildLoginBtn(),
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
    );
  }
}