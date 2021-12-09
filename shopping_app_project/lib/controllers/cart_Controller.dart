import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_project/constants/app_Constants.dart';
import 'package:shopping_app_project/constants/controllers.dart';
import 'package:shopping_app_project/models/cart_Items.dart';
import 'package:shopping_app_project/models/products.dart';
import 'package:shopping_app_project/models/user.dart';
import 'package:uuid/uuid.dart';

class Cart_Controller extends GetxController {
  static Cart_Controller instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void removeCartItem(Cart_Items_Model cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
    }
  }

  changeCartTotalPrice(User_Model userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart!.isNotEmpty) {
      userModel.cart!.forEach((cartItem) {
        totalCartPrice.value += cartItem.cost!;
      });
    }
  }

  void addProductToCart(Products_Model product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.name} is already added");
      } else {
        String itemId = Uuid().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "productId": product.id,
              "name": product.name,
              "quantity": 1,
              "price": product.price,
              "image": product.image,
              "cost": product.price
            }
          ])
        });
        Get.snackbar("Item added", "${product.name} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  bool _isItemAlreadyAdded(Products_Model product) =>
      userController.userModel.value.cart!
          .where((item) => item.productId == product.id)
          .isNotEmpty;

  void decreaseQuantity(Cart_Items_Model item) {
    if (item.quantity! == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity = item.quantity! - 1;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(Cart_Items_Model item) {
    removeCartItem(item);
    item.quantity = item.quantity! + 1;
    logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
