import 'package:get/get.dart';

import '../model/countries.dart';
import '../requests/countries.dart';

class CountriesController extends GetxController {
  var countries = <CountriesModel>[].obs;
  RxBool isLoading = false.obs;

  void getCountries() async {
    isLoading.toggle();
    countries.value = await CountriesRequests.getCountries();
    isLoading.toggle();
  }
}