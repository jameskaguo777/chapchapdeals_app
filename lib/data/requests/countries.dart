import 'package:dio/dio.dart';

import '../api.dart';
import '../model/countries.dart';

class CountriesRequests {
  static Future<List<CountriesModel>> getCountries() async {
    try {
      Response response = await Dio().get(
        countriesUrl,
      );
      if (response.data['success'] == true) {
        return (response.data['result'] as List)
            .map((e) => CountriesModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      return [];
    }
  }
}