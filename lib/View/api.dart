import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/ApiModel.dart';

class Api extends StatelessWidget {
  const Api({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<ApiModel> getdata() async {
      final response =
      await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return ApiModel.fromJson(data);
      } else {
        throw Exception(
          Text("error"),
        );
      }
    }

    return Scaffold(

    );
  }
}
