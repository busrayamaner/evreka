import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evreka/routes/page_names.dart';
import 'package:evreka/services/auth_services.dart';
import 'package:evreka/widgets/dialogs/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController userNameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool loginButtonEnable = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //Check empty fields
  void controlLoginButton() {
    if (userNameTEC.value.text.trim() != "" &&
        passwordTEC.value.text.trim() != "") {
      loginButtonEnable.value = true;
    } else {
      loginButtonEnable.value = false;
    }
  }

  //Sign in method
  Future<bool> signInWithEmailAndPassword() async {
    try {
      //check username from firebase
      bool userNameValid = await isUsernameAvailable();

      if (!userNameValid) {
        CustomSnackBar.show(Get.context!, "There is no such username!");
        return false;
      } else {
        // Fetch user from firebase and control it
        UserCredential? userCredential = await AuthServices()
            .loginApp(email: userNameTEC.text, password: passwordTEC.text);
        User? user = userCredential?.user;
        if (user == null) {
          CustomSnackBar.show(
              Get.context!, "Username or password is incorrect");
          return false;
        } else {
          Get.toNamed(PageNames.shared.mapPage);
          return true;
        }
      }
    } on FirebaseAuthException catch (e) {
      CustomSnackBar.show(Get.context!, e.message ?? "Unexpected error");
      return false;
    } catch (e) {
      // A separate warning was given to see the error in debug mode.
      if (kDebugMode) {
        CustomSnackBar.show(Get.context!, e.toString());
      } else {
        CustomSnackBar.show(Get.context!, "Unexpected error");
      }
      return false;
    }
  }

  Future<bool> isUsernameAvailable() async {
    final CollectionReference usernamesCollection =
        FirebaseFirestore.instance.collection('users');

    final querySnapshot = await usernamesCollection
        .where('username', isEqualTo: userNameTEC.text)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
