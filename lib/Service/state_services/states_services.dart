import 'dart:convert';
import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/Service/app_url/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesUrl));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesList() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
