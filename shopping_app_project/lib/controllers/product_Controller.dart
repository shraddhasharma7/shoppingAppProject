import 'dart:async';
import 'package:get/get.dart';
import 'package:shopping_app_project/constants/firebase.dart';
import 'package:shopping_app_project/models/products.dart';

// ignore: camel_case_types
class Product_Controller extends GetxController {
  static Product_Controller instance = Get.find();
  RxList<Products_Model> products = RxList<Products_Model>([]);
  String collection = "products";

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
  }

  Stream<List<Products_Model>> getAllProducts() => firebaseFirestore
      .collection(collection)
      .snapshots()
      .map((query) => query.docs
          .map((item) => Products_Model.fromMap(item.data()))
          .toList());
}
