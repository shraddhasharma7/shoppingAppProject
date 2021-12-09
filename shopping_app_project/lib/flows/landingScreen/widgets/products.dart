import 'package:flutter/material.dart';
import 'package:shopping_app_project/constants/controllers.dart';
import 'package:shopping_app_project/models/products.dart';
import 'package:shopping_app_project/flows/landingScreen/widgets/single_Product.dart';
import 'package:get/get.dart';

class Products_Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .63,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 10,
        children: productsController.products.map((Products_Model product) {
          return Single_Product_Widget(
            product: product,
          );
        }).toList()));
  }
}
