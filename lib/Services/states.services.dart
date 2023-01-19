import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/ApiModel.dart';
import '../Utlities/app_url.dart';

class StatesServices {
  var data;

  Future<ApiModel> fetchData() async {
    final  response = await http.get(Uri.parse(AppUrl.worldStateApi));
    // final jsondata= await  http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return ApiModel.fromJson(data);
    } else {
      throw Exception("Error occurred");
    }
  }
  Future<List<dynamic>> countriesData() async {
    var data;
    final  response = await http.get(Uri.parse(AppUrl.countriesList));
    // final jsondata= await  http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {

      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error occurred");
    }
  }
}
