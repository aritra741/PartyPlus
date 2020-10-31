import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentProvider with ChangeNotifier {
  final url = "https://sandbox.sslcommerz.com/gwprocess/v4/api.php";
  String _redirectUrl = '';

  String get redirectUrl {
    return _redirectUrl;
  }

  Future<void> chackPayment(String amount) async {
    final data = {
      'store_id': 'party5f95dc4515cf4',
      'store_passwd': 'party5f95dc4515cf4@ssl',
      'total_amount': '$amount',
      'currency': 'BDT',
      'tran_id': 'TEST' + UniqueKey().hashCode.toString(),
      'success_url': 'http://yoursite.com/success.php',
      'fail_url': 'http://yoursite.com/fail.php',
      'cancel_url': 'http://yoursite.com/cancel.php',
      'shipping_method': 'Courier',
      'product_name': 'Computer.',
      'product_category': 'Electronic',
      'product_profile': 'general',
      'cus_name': 'Nowshad',
      'cus_email': 'cust@email.com',
      'cus_add1': 'Dhaka',
      'cus_add2': 'Dhaka',
      'cus_city': 'Dhaka',
      'cus_state': 'Dhaka',
      'cus_postcode': '1207',
      'cus_country': 'Bangladesh',
      'cus_phone': '01867131525',
      'cus_fax': '01711111111',
      'ship_name': 'Customer Name',
      'ship_add1': 'Dhaka',
      'ship_add2': 'Dhaka',
      'ship_city': 'Dhaka',
      'ship_state': 'Dhaka',
      'ship_postcode': '1207',
      'ship_country': 'Bangladesh',
      'value_a': 'ref001_A',
      'value_b': 'ref002_B',
      'value_c': 'ref003_C',
      'value_d': 'ref004_D'
    };
    final http.Response response = await http.post(
      url,
      body: data,
    );
    print(response.body);

    _redirectUrl = jsonDecode(response.body)['GatewayPageURL'];
    notifyListeners();
  }
}