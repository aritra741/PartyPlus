import 'package:flutter/material.dart';
import 'package:partyplus/constants/constants_for_login.dart';
import 'package:partyplus/screens/addon_dummy_page.dart';
import 'package:partyplus/screens/login_screen.dart';
import 'package:partyplus/screens/register_screen.dart';
import 'package:partyplus/screens/search_screen_body.dart';
import 'package:partyplus/constants/constants_for_search_screen_top.dart';

class ModifyReservation extends StatefulWidget {
  Map<String, dynamic> data;
  ModifyReservation({this.data});
  @override
  _ModifyReservationState createState() => _ModifyReservationState(data);
}

class _ModifyReservationState extends State<ModifyReservation> {

  Map<String, dynamic> data;
  _ModifyReservationState(this.data);
  var userEmail= TextEditingController();
  var userPhone= TextEditingController();
  var userName= TextEditingController();
  int currentIndex= 1;
  int num_of_days= 3, check= 3;
  bool pressed= false;
  String shiftTextstr1="",shiftTextstr2="",shiftTextstr3="";
  List<bool> dayOneShift = [false,false,false], dayTwoShift = [false,false,false], dayThreeShift = [false,false,false];
  String shiftBitstr1="",shiftBitstr2="",shiftBitstr3="";
  String takatext1,takatext2,takatext3;
  int total_cost= 0;

  @override
  void dispose() {
    userEmail.dispose();
    userName.dispose();
    userPhone.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    print("eeeeeeeeeeeeeeeeeeehehhhhhhhhhe");
   // ShiftString();
    if(data['numofdays']=="1") num_of_days=1;
    else if(data['numofdays']=="2") num_of_days=2;
    else num_of_days=3;
    makeshift();
    ShiftString();
  }
  void makeshift()
  {
    shiftTextstr1="";
    shiftTextstr2="";
    shiftTextstr3="";
    List<String> shft = ['Morning','Noon','Evening'];
    /*for( int i=0;i<3;i++ )
    {
      dayOneShift.add(false);
      dayTwoShift.add(false);
      dayThreeShift.add(false);
    }*/
    for(int i=0;i<3;i++)
      {
        if(i < data['shift1'].length && data['shift1'][i]=='1')
          {
            if(shiftTextstr1.length!=0) shiftTextstr1+="\n";
            dayOneShift[i] = true;
            shiftTextstr1 += shft[i];
          }
        if(i < data['shift2'].length && data['shift2'][i]=='1')
        {
          dayTwoShift[i] = true;
          if(shiftTextstr2.length!=0) shiftTextstr2+="\n";
          shiftTextstr2 += shft[i];
        }
        if( i < data['shift3'].length && data['shift3'][i]=='1')
        {
          dayThreeShift[i] = true;
          if(shiftTextstr3.length!=0) shiftTextstr3+="\n";
          shiftTextstr3 += shft[i];
        }

      }
    //total_cost = data['totalCost'];
    return;
  }

  void ShiftString()
  {
    print("Ss");
    //String s;
    shiftBitstr1="";
    shiftBitstr2="";
    shiftBitstr3="";
    shiftTextstr1 = "";
    shiftTextstr2 = "";
    shiftTextstr3 = "";
    takatext1="";
    takatext2="";
    takatext3="";
    total_cost = 0;
    String mxprice = "100000";
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
        takatext1+=mxprice;
        takatext1 += "\u09F3";
        shiftTextstr1 += shft[i];
        total_cost += int.parse(mxprice);
      }
      else shiftBitstr1 +=  "0";
      if(dayTwoShift[i]==true)
      {
        shiftBitstr2+="1";
        if(shiftTextstr2!="") shiftTextstr2+="\n";
        if(takatext2!="") takatext2+="\n";
        takatext2+=mxprice;
        takatext2 += "\u09F3";
        shiftTextstr2 += shft[i];
        total_cost += int.parse(mxprice);
      }
      else shiftBitstr2 += "0'";
      if(dayThreeShift[i]==true)
      {
        shiftBitstr3+= "1";
        if(shiftTextstr3!="") shiftTextstr3+="\n";
        if(takatext3!="") takatext3+="\n";
        takatext3+=mxprice;
        takatext3 += "\u09F3";
        shiftTextstr3 += shft[i];
        total_cost += int.parse(mxprice);
      }
      else shiftBitstr3 += "0";
      print(shiftBitstr1);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    userEmail.text = data['email'];
    userPhone.text = data['phoneNumber'];
    userName.text = data['name'];
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
                      if(num_of_days >= 1)
                        AddRemoveButton1(),
                      if(num_of_days>=2)
                        widgetforszbox(2),
                      if(num_of_days>=2)
                        PriceDetails(2),
                      if(num_of_days >= 2)
                        AddRemoveButton2(),
                      if(num_of_days>=3)
                        widgetforszbox(3),
                      if(num_of_days>=3)
                        PriceDetails(3),
                      if(num_of_days >= 3)
                        AddRemoveButton3(),
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
              child: Row(
                children: <Widget>[
              Container(
              margin: EdgeInsets.only(top: kDefaultPadding),
              width: 150,
              height: 50,
              child: RaisedButton(
                elevation: 5.0,
                onPressed: (){
                  setState(() {
                    pressed= true;
                   // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddOnDummy()));
                  });
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Color(0xFF005e6a),
                child: Text(
                  'Delete',
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
                  SizedBox(width: 10,),

                  Container(
                    margin: EdgeInsets.only(top: kDefaultPadding),
                    width: 200,
                    height: 50,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: (){
                        setState(() {
                          pressed= true;
                        });
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Color(0xFF005e6a),
                      child: Text(
                        'UPDATE',
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
            )
          ],
        ),
      ),
    );
  }
  Widget VAT(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 150),
        Container(
            child:  Text("VAT",
                style: TextStyle(color: Colors.black, fontSize: 16.0,))
        ),

        SizedBox(width: 100),
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
        SizedBox(width: 150),
        Container(
            child:  Text("Service Fee",
                style: TextStyle(color: Colors.black, fontSize: 16.0,))
        ),

        SizedBox(width: 65),
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

  Widget widgetforszbox(int n){
    if(num_of_days>=2 && n==2)
      return SizedBox(height: 10,);
    else if(num_of_days>=3 && n==3)
      return SizedBox(height: 10,);
    else if(n==4)
      return SizedBox(height: 10,);
  }

  Widget PriceDetails(int check)
  {

    if(num_of_days>=1 && check==1)
    {
      return Row(

        children: <Widget>[
          // SizedBox(height: 80),
          Container(
            child:  Text(data['date1'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr1,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),),
              ],
            ),
          ),
          SizedBox(width: 50),
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
            child:  Text(data['date2'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr2,
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
            child:  Text(data['date3'],
              style: TextStyle(color: Colors.black, fontSize: 16.0),),
          ),
          SizedBox(width: 80),
          Container(
            child: new Column(
              children: <Widget>[
                Text(shiftTextstr3,
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
  Widget TotalPrice(){
    return Row(
      children: <Widget>[
        // SizedBox(height: 50),
        SizedBox(width: 150),
        Container(
            child:  Text("Total",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold))
        ),

        SizedBox(width: 83),
        Container(
          child: new Column(
            children: <Widget>[
              Text((total_cost).toString()+ "\u09F3",
                style: TextStyle(color: Colors.black, fontSize: 16.0,
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ],
    );
  }

  Widget AddRemoveButton1() {
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
              child: InkWell(
                  onTap: () => {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      ShiftString();
                                    });
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pop();
                                  },

                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    padding:
                                    EdgeInsets.only(left: 11, top: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF005e6a),
                                    ),
                                    child: Text("ok",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white)),
                                  ))
                            ],
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setState) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CheckboxListTile(
                                      value: dayOneShift[0],
                                      title: Text("Morning"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayOneShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayOneShift[2],
                                      title: Text("Evening"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayOneShift[2] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        })
                  },
                  child: Text(
                    "Add/Remove",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                      fontSize: 16.0,
                    ),
                  )
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget AddRemoveButton2() {
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
              child: InkWell(
                  onTap: () => {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {

                                    setState(() {
                                      ShiftString();
                                    });
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pop();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    padding:
                                    EdgeInsets.only(left: 11, top: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF005e6a),
                                    ),
                                    child: Text("ok",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white)),
                                  ))
                            ],
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setState) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CheckboxListTile(
                                      value: dayTwoShift[0],
                                      title: Text("Morning"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayTwoShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayTwoShift[2],
                                      title: Text("Evening"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayTwoShift[2] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        })
                  },
                  child: Text(
                    "Add/Remove",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                      fontSize: 16.0,
                    ),
                  )
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget AddRemoveButton3() {
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
              child: InkWell(
                  onTap: () => {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Shift(s)"),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      ShiftString();
                                    });
                                    Navigator.of(context,
                                        rootNavigator: true)
                                        .pop();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 50,
                                    padding:
                                    EdgeInsets.only(left: 11, top: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF005e6a),
                                    ),
                                    child: Text("ok",
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.white)),
                                  ))
                            ],
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setState) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    CheckboxListTile(
                                      value: dayThreeShift[0],
                                      title: Text("Morning"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[0] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayThreeShift[1],
                                      title: Text("Noon"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[1] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      value: dayThreeShift[2],
                                      title: Text("Evening"),
                                      onChanged: (value) {
                                        setState(() {
                                          dayThreeShift[2] = value;
                                          // getShiftInfoForDayOne(_morning, _evening, _night);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        })
                  },
                  child: Text(
                    "Add/Remove",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                      fontSize: 16.0,
                    ),
                  )
                //textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
      ],
    );
  }

}
