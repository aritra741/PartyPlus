
//import 'package:daktarbari_demo/model/appointment_request.dart';
import 'package:partyplus/constants.dart';
import 'package:partyplus/providers/payment_provider.dart';
import 'package:partyplus/screens/payment_statust_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  static String routeName = '/webview';
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // AppointmentRequest request = ModalRoute.of(context).settings.arguments;
    try {
      Future.wait([
        Provider.of<PaymentProvider>(context, listen: false)
            .chackPayment(/*request.paidAmount*/"5000"),
      ]).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (err) {
      throw err;
    }
    String url =
        Provider.of<PaymentProvider>(context, listen: false).redirectUrl;
    print('GatewayPageURL: ' + url);

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (navigation) {
              if (navigation.url.endsWith('success.php')) {
                Navigator.pushNamed(
                  context,
                  PaymentStatusScreen.routeName,
                  arguments: {
                    'status': paymentStatus.SUCCESS,
                   // 'request': "success"
                  },
                );
                return NavigationDecision.prevent;
              }
              if (navigation.url.endsWith('cancel.php')) {
                Navigator.pushNamed(
                  context,
                  PaymentStatusScreen.routeName,
                  arguments: {
                    'status': paymentStatus.CANCEL,
                    //'request': "cancel"
                  },
                );
                return NavigationDecision.prevent;
              }
              if (navigation.url.endsWith('fail.php')) {
                Navigator.pushNamed(
                  context,
                  PaymentStatusScreen.routeName,
                  arguments: {
                    'status': paymentStatus.FAIL,
                   // 'request':"sc"
                  },
                );
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      ),
    );
  }
}