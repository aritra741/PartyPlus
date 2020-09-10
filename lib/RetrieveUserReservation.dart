import 'package:flutter/material.dart';
import 'package:partyplus/Reservation.dart';
import 'package:partyplus/screens/modify_reservation.dart';


class RetrieveUserReservation extends StatefulWidget {
  @override
  _RetrieveUserReservationState createState() => _RetrieveUserReservationState();
}

class _RetrieveUserReservationState extends State<RetrieveUserReservation> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PartyPlus"),
          backgroundColor: Color(0xFF005e6a),
        ),
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
                  return reservationlist(list[index].date, list[index].convname);
                }
            ),
            ),
          ],
        ),

      ),
    );
  }
  List<Reservation> list = [];

  @override
  void initState(){
    super.initState();
    Reservation test = new Reservation("10.09.2020", "Khan's Palace");
    Reservation test2 = new Reservation("10.09.2020", "King of Chittagong");
    list.add(test);
    list.add(test2);
  }



  Widget reservationlist(String date,String name)
  {
    return new Card(
      elevation: 10.0,
      // margin: EdgeInsets.all(15.0),

      child: new InkWell(
        onTap: () {
         Navigator.push(context,MaterialPageRoute(builder: (context)=>ModifyReservation()));
        },
        child: new Container(
          padding: new EdgeInsets.all(14.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    date,
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              new Text(
                name,
                //style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }






}

