import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app_project/controllers/product_Controller.dart';
import 'package:shopping_app_project/flows/splash/splash_Screen.dart';

import 'constants/firebase.dart';
import 'controllers/app_Controller.dart';
import 'controllers/auth_Controller.dart';
import 'controllers/cart_Controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(App_Controller());
    Get.put(User_Controller());
    Get.put(Product_Controller());
    Get.put(Cart_Controller());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        shadowColor: Colors.purple.shade100,
      ),
      home: Splash_Screen(),
    );
  }
}
