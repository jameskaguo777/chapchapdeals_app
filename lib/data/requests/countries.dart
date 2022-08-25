import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<String> getPrefferedCountry() async {
    return (await SharedPreferences.getInstance()).getString('country') ?? '';
  }

  static String getCountryFlagImage(String countryCode) {
    return getCountryFlagImageUrl.replaceAll('countryCode', countryCode);
  }

  static Future<bool> setPrefferedCountry(String country) async {
    return (await SharedPreferences.getInstance()).setString('country', country);
  }

  static Future<bool> setCountryCurrency(String country) async {
    return (await SharedPreferences.getInstance()).setString('currency', country);
  }

  static Future<String> getCountryCurrency() async{
    return (await SharedPreferences.getInstance()).getString('currency') ?? '';
  }
  
}
