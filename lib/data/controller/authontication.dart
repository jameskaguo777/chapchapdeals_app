import 'package:chapchapdeals_app/data/requests/authontication.dart';
import 'package:get/get.dart';

class AuthonticationController extends GetxController {
  RxBool isLogedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (AuthonticationRequests.getToken().isBlank!) {
      isLogedIn.value = false;
    } else {
      isLogedIn.value = true;
    }
  }
}
