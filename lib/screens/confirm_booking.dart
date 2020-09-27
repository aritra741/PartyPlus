import 'package:flutter/material.dart';
import 'package:partyplus/constants/constants_for_login.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ConfirmBooking extends StatefulWidget {
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  var userEmail= TextEditingController(text: "aritra741@gmail.com");
  var userPhone= TextEditingController(text: "01555514523");
  var userName= TextEditingController(text: "Aritra Mazumder");
  int currentIndex= 1;
  int num_of_days= 3, check= 3;
  bool pressed= false;

  @override
  void dispose() {
    userEmail.dispose();
    userName.dispose();
    userPhone.dispose();
    super.dispose();
  }

  Future postData() async{

    var match = {
      "convname" : "Khan's Palace",
      "numofdays" : "2",
      "date1" : "28.09.2020",
      "date2" : "29.09.2020",
      "date3" : "30.09.2020",
      "shift1" : "111",
      "shift2" : "101",
      "shift3" : "011",
      "price1" : "50000\n50000\n50000",
      "price2" : "50000\n50000",
      "price3" : "50000\n50000",
      "totalCost" : "350000",
      "email" : "aritra741@gmail.com",
      "id" : "1",
      "name" : "Aritra",
      "phoneNumber" : "0152342",

    };

    print( json.encode(match) );

    print("HYSE??");
    // print(SearchScreenBody.numberOfDays);
    final String apiurl = "http://partyplusapi.herokuapp.com/book";
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
    };

    //print("HYSE??");
    // body: json.encode(match),);
    //  data = json.decode(response.body);
    //  debugPrint(fuserData.toString());
    //  setState(() {
    //    fuserData = data['Name'];
    //  });
    //  debugPrint(fuserData.toString());
    print(response.body);
    //  return fuserData;


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
              height: 10,
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
                      PriceDetails(1),
                      AddRemoveButton(),
                      widgetforszbox(2),
                      PriceDetails(2),
                      AddRemoveButton(),
                      widgetforszbox(3),
                      PriceDetails(3),
                      AddRemoveButton(),
                      widgetforszbox(4),
                      TotalPrice(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              width: 200,
              height: 50,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: (){
                  postData();
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF005e6a),
                child: Text(
                  'CONFIRM',
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
      ),
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
  Widget AddRemoveButton(){
    return Row(
      children: <Widget>[
        SizedBox(width: 145),
        InkWell(
          // onTap: doSomething,
          child: SizedBox(
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.blue
              ),
              child: Text(
                "Add/Remove",style: TextStyle(
                decoration: TextDecoration.underline,color: Colors.teal, fontSize: 16.0,
              ),
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget PriceDetails(int check)
  {
    num_of_days=3;
    if(num_of_days>=1 && check==1)
    {
      return Row(

        children: <Widget>[
          // SizedBox(height: 80),
          Container(
            child:  Text("12.08.2020",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text("Morning\nEvening\n  Night",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
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
            child:  Text("13.08.2020",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text("Morning\nEvening\n  Night",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
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
            child:  Text("14.08.2020",
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text("Morning\nEvening\n  Night",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("10000\u09F3\n10000\u09F3\n10000\u09F3",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Container();
    }
  }
  Widget TotalPrice(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 170),
        Container(
            child:  Text("Total",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 100),
        Container(
          child: new Column(
            children: <Widget>[
              Text("90000\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }

}
