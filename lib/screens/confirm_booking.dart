import 'package:flutter/material.dart';
import 'package:partyplus/constants/constants_for_login.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:partyplus/providers/conventionHall.dart';

class ConfirmBooking extends StatefulWidget {
  conventionHall convention ;
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  ConfirmBooking({this.convention,this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift});
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState(convention,searchstring,dayString,selectedDate,secDate,thDate,dayOneShift, dayTwoShift, dayThreeShift);
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  var userEmail= TextEditingController(text: "aritra741@gmail.com");
  var userPhone= TextEditingController(text: "01555514523");
  var userName= TextEditingController(text: "Aritra Mazumder");
  int currentIndex= 1;
  int num_of_days= 3, check= 3;
  bool pressed= false;

  Future _future;
  conventionHall convention ;
  String searchstring,dayString;
  DateTime selectedDate,secDate,thDate;
  List<bool> dayOneShift, dayTwoShift, dayThreeShift;
  String date1,date2,date3,booking_id;
  String shiftBitstr1="",shiftBitstr2="",shiftBitstr3="";
  String shiftTextstr1,shiftTextstr2,shiftTextstr3;
  String takatext1,takatext2,takatext3;
  double total_cost= 0;
  _ConfirmBookingState(this.convention,this.searchstring,this.dayString,this.selectedDate,this.secDate,this.thDate,this.dayOneShift, this.dayTwoShift, this.dayThreeShift);
  @override
  void dispose() {
    userEmail.dispose();
    userName.dispose();
    userPhone.dispose();
    super.dispose();
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void confirm()
  {
    setState(() {
      booking_id = getRandomString(20)+getLastName();
    });
    _future= postData();
  }

  Future postData() async{

    var match = {
      "convname" : convention.Name,
      "numofdays" : dayString,
      "date1" : date1,
      "date2" : date2,
      "date3" : date3,
      "shift1" : shiftBitstr1,
      "shift2" : shiftBitstr2,
      "shift3" : shiftBitstr3,
      "price1" : takatext1,
      "price2" : takatext2,
      "price3" : takatext3,
      "totalCost" : total_cost.ceil().toString(),
      "email" : userEmail.text,
      "id" : booking_id,
      "name" : userName.text,
      "phoneNumber" : userPhone.text,
      "pershiftprice": convention.mxprice.toString()
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
    // print(response.body);
    //  return fuserData;
  }

  String getLastName()
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

    return nameList[nameList.length-1];
  }

  @override
  void initState(){
    super.initState();
    ShiftString();
    if(dayString=="1") num_of_days=1;
    else if(dayString=="2") num_of_days=2;
    else num_of_days=3;
  }
  @override
  Widget build(BuildContext context) {
    date1 = "${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}";
    date2 = "${secDate.day.toString()}-${secDate.month.toString()}-${secDate.year.toString()}";
    date3 = "${thDate.day.toString()}-${thDate.month.toString()}-${thDate.year.toString()}";

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
                      if(num_of_days>=1)
                      PriceDetails(1),
                      if(num_of_days>=2)
                      widgetforszbox(2),
                      if(num_of_days>=2)
                      PriceDetails(2),
                      if(num_of_days>=3)
                      widgetforszbox(3),
                      if(num_of_days>=3)
                      PriceDetails(3),
                      SizedBox(height: 10,),
                      VAT(),
                      SizedBox(height: 10,),
                      ServiceFee(),
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
                //  ShiftString();
                  confirm();
                  showGeneralDialog(

                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation,
                          Animation secondaryAnimation) {
                        return Center(


                          child: Container(

                            width: MediaQuery.of(context).size.width - 0,
                            height: MediaQuery.of(context).size.height-150,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child : Card(
                            elevation: 0,
                            child: Container(
                              //padding: EdgeInsets.only(top: 20),
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  Text("Booking Receipt",style: TextStyle(color: Colors.black, fontSize: 20.0,
                                  fontWeight: FontWeight.bold),),
                              SelectableText("\nConvention Hall Name : " + convention.Name +"\n" +
                              "Name : " + userName.text + "\n" +
                              "Email : " + userEmail.text + "\n" +
                              "Phone Number : "  + userPhone.text + "\n" +
                              "Booking Id : " + booking_id + "\n"),
                                  if(num_of_days>=1)
                                  PriceDetails(1),
                                  if(num_of_days>=2)
                                  widgetforszbox(2),
                                  if(num_of_days>=2)
                                  PriceDetails(2),
                                  if(num_of_days>=3)
                                  widgetforszbox(3),
                                  if(num_of_days>=3)
                                  PriceDetails(3),
                                  SizedBox(height: 10,),
                                  VAT(),
                                  SizedBox(height: 10,),
                                  ServiceFee(),
                                  widgetforszbox(4),
                                  TotalPrice(),
                                  RaisedButton(

                                    onPressed: () {
                                      showGeneralDialog(

                                          context: context,
                                          barrierDismissible: true,
                                          barrierLabel: MaterialLocalizations.of(context)
                                              .modalBarrierDismissLabel,
                                          barrierColor: Colors.black45,
                                          transitionDuration: const Duration(milliseconds: 200),
                                          pageBuilder: (BuildContext buildContext,
                                              Animation animation,
                                              Animation secondaryAnimation) {
                                            return Center(


                                              child: Container(

                                                width: MediaQuery.of(context).size.width - 0,
                                                height: MediaQuery.of(context).size.height-150,
                                                padding: EdgeInsets.all(20),
                                                color: Colors.white,
                                                child : Card(
                                                  elevation: 0,
                                                  child: Container(
                                                    //padding: EdgeInsets.only(top: 20),
                                                    height: 400,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Column(
                                                      children: <Widget>[
                                                        SelectableText("Please make sure that you have copied the Booking Id : " + booking_id + "\n",style: TextStyle(color: Colors.black, fontSize: 15.0,
                                                            fontWeight: FontWeight.bold),),
                                                        RaisedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => SearchScreenBody()),);
                                                          },
                                                          child: Text(
                                                            "OK",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          color: const Color(0xFF1BC0C5),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),//card
                                              ),
                                            );
                                          });
                                    /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SearchScreenBody()),);*/
                                    },
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  )
                                ],
                              ),
                            ),
                         ),//card
                          ),
                        );
                      });
                  /*showGeneralDialog(

                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation,
                          Animation secondaryAnimation) {
                        return Center(


                          child: Container(

                            width: MediaQuery.of(context).size.width - 0,
                            height: MediaQuery.of(context).size.height-150,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child : Card(
                              elevation: 0,
                              child: Container(
                                //padding: EdgeInsets.only(top: 20),
                                height: 400,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: <Widget>[
                                    SelectableText("Please make sure that you have copied the Booking Id : " + booking_id + "\n",style: TextStyle(color: Colors.black, fontSize: 15.0,
                                        fontWeight: FontWeight.bold),),
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SearchScreenBody()),);
                                      },
                                      child: Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: const Color(0xFF1BC0C5),
                                    )
                                  ],
                                ),
                              ),
                            ),//card
                          ),
                        );
                      });*/
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
  void ShiftString()
  {
    print("Ss");
    //String s;
    total_cost=0;
    shiftBitstr1="";
    shiftBitstr2="";
    shiftBitstr3="";
    shiftTextstr1 = "";
    shiftTextstr2 = "";
    shiftTextstr3 = "";
    takatext1="";
    takatext2="";
    takatext3="";
    List<String> shft = ['Morning','Noon','Evening'];
    for(int i=0;i<3;i++)
      {
        print(dayOneShift[i]);
        print(dayTwoShift[i]);
        print(dayThreeShift[i]);
      }

    for(int i=0;i<3;i++)
      {
        if(dayOneShift[i]==true)
          {

            shiftBitstr1 += "1";
            if(shiftTextstr1!="") shiftTextstr1+="\n";
            if(takatext1!="") takatext1+="\n";
            takatext1+=convention.mxprice.toString();
            takatext1 += "\u09F3";
            shiftTextstr1 += shft[i];
            total_cost += double.parse(convention.mxprice);
          }
        else shiftBitstr1 +=  "0";
        if(dayTwoShift[i]==true)
        {
          shiftBitstr2+="1";
          if(shiftTextstr2!="") shiftTextstr2+="\n";
          if(takatext2!="") takatext2+="\n";
          takatext2+=convention.mxprice.toString();
          takatext2 += "\u09F3";
          shiftTextstr2 += shft[i];
          total_cost += double.parse(convention.mxprice);
        }
        else shiftBitstr2 += "0";
        if(dayThreeShift[i]==true)
        {
          shiftBitstr3+= "1";
          if(shiftTextstr3!="") shiftTextstr3+="\n";
          if(takatext3!="") takatext3+="\n";
          takatext3+=convention.mxprice.toString();
          takatext3 += "\u09F3";
          shiftTextstr3 += shft[i];
          total_cost += double.parse(convention.mxprice);
        }
        else shiftBitstr3 += "0";
        print(shiftBitstr1);
      }
    total_cost *= 1.15;
    return;
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

    if(num_of_days>=1 && check==1)
    {
      return Row(

        children: <Widget>[
          // SizedBox(height: 80),
          Container(
            child:  Text(date1,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr1,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext1,
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
            child:  Text(date2,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr2,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext2,
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
            child:  Text(date3,
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 35),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr3,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 60),
          Container(
            child: new Column(

              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(takatext3,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Row(children: <Widget>[
        Text("d")
      ],);
    }
  }
  Widget VAT(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 130),
        Container(
            child:  Text("VAT",
                style: TextStyle(color: Colors.black, fontSize: 16.0,))
        ),

        SizedBox(width: 95),
        Container(
          child: new Column(
            children: <Widget>[
              Text("15%",
                style: TextStyle(color: Colors.black, fontSize: 16.0,),),
            ],
          ),
        ),
      ],
    );
  }
  Widget ServiceFee(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 110),
        Container(
            child:  Text("Service Fee",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 70),
        Container(
          child: new Column(
            children: <Widget>[
              Text("0" + "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,),),
            ],
          ),
        ),
      ],
    );
  }
  Widget TotalPrice(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 130),
        Container(
            child:  Text("Total",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 70),
        Container(
          child: new Column(
            children: <Widget>[
              Text((total_cost.ceil()).toString() + "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }

}
