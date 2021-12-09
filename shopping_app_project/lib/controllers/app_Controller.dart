import 'package:get/get.dart';

// ignore: camel_case_types
class App_Controller extends GetxController {
  static App_Controller instance = Get.find();
  RxBool isLoginWidgetDisplayed = true.obs;

  changeDIsplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }
}
