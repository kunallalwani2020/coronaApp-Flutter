import 'dart:convert';

import 'package:corona_app/model/78_affected_countries_230.dart';
import 'package:corona_app/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateService {
  Future<worldStatemodel> fetchWorldStateData() async {
    final response = await http.get(Uri.parse(AppUrl.worldstate));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return worldStatemodel.fromJson(data);
    } else {
      throw Exception("WorldData error");
    }
  }

  Future<List<dynamic>> countriesApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countries));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("CountryData Error");
    }
  }
}
