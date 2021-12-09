import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_project/constants/app_Constants.dart';
import 'package:shopping_app_project/constants/firebase.dart';
import 'package:shopping_app_project/models/user.dart';
import 'package:shopping_app_project/flows/loginAndSignup/authentication.dart';
import 'package:shopping_app_project/flows/landingScreen/home_Screen.dart';
import 'package:shopping_app_project/utils/helpers/show_Loading.dart';

// ignore: camel_case_types
class User_Controller extends GetxController {
  static User_Controller instance = Get.find();
  late Rx<User?> firebaseUser;
  RxBool isLoggedIn = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String usersCollection = "users";
  Rx<User_Model> userModel = User_Model().obs;

  @override
  void onReady() {
    super.onReady();
    checkUserAndPerformAction();
  }

  void checkUserAndPerformAction() {
    if (auth.currentUser == null) {
      Get.offAll(() => Authentication_Screen());
      //Get.offAll(() => HomeScreen());
    } else {
      firebaseUser = Rx<User>(auth.currentUser!);
      firebaseUser.bindStream(auth.userChanges());
      ever(firebaseUser, _setInitialScreen);
    }
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Authentication_Screen());
      //Get.offAll(() => HomeScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => Home_Screen());
    }
  }

  void signIn() async {
    try {
      show_Loading();
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _clearControllers();
        checkUserAndPerformAction();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp() async {
    show_Loading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user!.uid;
        _addUserToFirestore(_userId);
        _clearControllers();
        checkUserAndPerformAction();
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
      "cart": []
    });
  }

  _clearControllers() {
    name.clear();
    email.clear();
    password.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value!.uid)
        .update(data);
  }

  Stream<User_Model> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value!.uid)
      .snapshots()
      .map((snapshot) => User_Model.fromSnapshot(snapshot));
}
