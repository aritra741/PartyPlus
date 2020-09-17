import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
import 'package:partyplus/widgets/show_dialog_for_days.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class DbTest
{
  Future<void> getData() async
  {
    print("ashchhe\n");
      var response= await http.get(
          Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
          headers: {
            "Accept": "application/json"
          }
      );

      List data= json.decode(response.body);
      print(data);
  }
}