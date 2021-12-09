import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app_project/flows/landingScreen/widgets/products.dart';

import 'package:shopping_app_project/widgets/custom_Text.dart';
import 'package:shopping_app_project/flows/landingScreen/widgets/shopping_Cart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shopping_app_project/constants/controllers.dart';

// ignore: camel_case_types
class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade100,
          iconTheme: IconThemeData(color: Colors.black),
          title: Custom_Text(
            text: "Fruit Basket",
            size: 24,
            weight: FontWeight.bold,
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  showBarModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      color: Colors.white,
                      child: Shopping_Cart_Widget(),
                    ),
                  );
                })
          ],
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            children: [
              Obx(() => UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.purple.shade100),
                    accountName: Custom_Text(
                      text: userController.userModel.value.name ?? "",
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                    accountEmail: Custom_Text(
                      text: userController.userModel.value.email ?? "",
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  )),
              ListTile(
                onTap: () {
                  userController.signOut();
                },
                leading: Icon(Icons.logout),
                title: Text("Sign out"),
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.white30,
          child: Products_Widget(),
        ));
  }
}
