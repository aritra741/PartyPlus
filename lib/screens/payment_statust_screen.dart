import 'package:partyplus/constants.dart';
//import 'package:daktarbari_demo/model/appointment_request.dart';
//import 'package:daktarbari_demo/providers/appointment_request_provider.dart';
//import 'package:daktarbari_demo/screens/landing_page_screen.dart';
import 'package:flutter/material.dart';


class PaymentStatusScreen extends StatefulWidget {
  static const routeName = '/pay';

  @override
  _PaymentStatusScreenState createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  String message = '';
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final map =
    ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final status = map['status'];
    print(status);
   // AppointmentRequest request = map['request'];
    // print(request.id);
    if (status == paymentStatus.SUCCESS) {
      setState(() {
        message =
        'Congratulations! You have successfully placed an appointment request.';
      });

    /*  _isLoading
          ? Provider.of<AppointmentRequestProvider>(context, listen: false)
          .addAppointmentRequest(request)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      })
          : Container();*/
    }
    if (status == paymentStatus.CANCEL) {
      setState(() {
        _isLoading = false;
        message =
        'Oh no! You have cancelled the payment as well as the appointment request.';
      });
    }
    if (status == paymentStatus.FAIL) {
      setState(() {
        _isLoading = false;
        message =
        'Sorry! Your payment has failed as well as the appointment request.';
      });
    }
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton(
                onPressed: () {
                  //Navigator.of(context)
                    //  .pushNamed(LandingPageScreen.routeName);
                },
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
