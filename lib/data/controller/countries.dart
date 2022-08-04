import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/countries.dart';
import '../requests/countries.dart';

class CountriesController extends GetxController {
  var countries = <CountriesModel>[].obs;
  RxString prefferedCountry = ''.obs;
  RxBool isLoading = false.obs;
  RxString countryFlagImage = ''.obs;
  RxBool isPrefferedCountrySet = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPrefferedCountry();
    getCountries();
    getImageFlagCountry('TZ');
  }

  void getCountries() async {
    isLoading.toggle();
    countries.value = await CountriesRequests.getCountries();
    isLoading.toggle();
  }

  void getPrefferedCountry() async {
    isLoading.toggle();
    prefferedCountry.value = await CountriesRequests.getPrefferedCountry();
    isLoading.toggle();
  }

  void getImageFlagCountry(String countryCode) async {
    isLoading.toggle();
    countryFlagImage.value = CountriesRequests.getCountryFlagImage(countryCode);
    isLoading.toggle();
  }

  void setPrefferedCountry(String country) async {
    isLoading.toggle();
    isPrefferedCountrySet.value =
        await CountriesRequests.setPrefferedCountry(country);
    isLoading.toggle();
  }
}
