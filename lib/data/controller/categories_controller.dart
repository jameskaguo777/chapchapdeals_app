import 'package:chapchapdeals_app/data/model/categories.dart';
import 'package:chapchapdeals_app/data/requests/categories.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var categories = <CategoriesModel>[].obs;
  RxBool isLoading = false.obs;
  RxString prefferedCategory = 'All'.obs;

  void getCategories() async {
    isLoading.toggle();
    categories.value = await CategoriesRequests.getCategories();
    isLoading.toggle();
  }
}
