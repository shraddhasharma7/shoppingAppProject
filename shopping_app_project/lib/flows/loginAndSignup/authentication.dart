import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app_project/controllers/app_Controller.dart';
import 'package:shopping_app_project/flows/loginAndSignup/widgets/bottom_Text.dart';
import 'package:shopping_app_project/flows/loginAndSignup/widgets/login_Screen.dart';
import 'package:shopping_app_project/flows/loginAndSignup/widgets/registration_Screen.dart';

class Authentication_Screen extends StatelessWidget {
  final App_Controller _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.width / 3),
                SizedBox(height: MediaQuery.of(context).size.width / 5),
                Visibility(
                    visible: _appController.isLoginWidgetDisplayed.value,
                    child: Login_Screen()),
                Visibility(
                    visible: !_appController.isLoginWidgetDisplayed.value,
                    child: Registration_Screen()),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _appController.isLoginWidgetDisplayed.value,
                  child: Bottom_Text_Widget(
                    onTap: () {
                      _appController.changeDIsplayedAuthWidget();
                    },
                    text1: "Don\'t have an account?",
                    text2: "Create account!",
                  ),
                ),
                Visibility(
                  visible: !_appController.isLoginWidgetDisplayed.value,
                  child: Bottom_Text_Widget(
                    onTap: () {
                      _appController.changeDIsplayedAuthWidget();
                    },
                    text1: "Already have an account?",
                    text2: "Sign in!!",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
