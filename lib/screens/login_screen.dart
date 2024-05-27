import 'package:evreka/controllers/login_controller.dart';
import 'package:evreka/globals/assets.dart';
import 'package:evreka/globals/dimentions.dart';
import 'package:evreka/globals/styles.dart';
import 'package:evreka/globals/text_styles.dart';
import 'package:evreka/widgets/buttons/button.dart';
import 'package:evreka/widgets/text_fields/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration:
            BoxDecoration(gradient: EvrekaDecoration.backgroundGradient),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildAppLogo(),
              SizedBox(height: 2.h),
              textfieldFormArea(),
              SizedBox(height: 10.h),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppLogo() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Image.asset(
        EvrekaAssets.evrakaLogo,
        width: 50.w,
      ),
    );
  }

  Widget textfieldFormArea() {
    return Container(
      margin: EvrekaDimentions.margin,
      height: 30.h,
      child: Form(
        key: controller.loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Please enter your username and password.",
              style: EvrekaTextStyles.t2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            EvrekaTextField(
              hint: "Username",
              cont: controller.userNameTEC,
              onChanged: (p0) {
                controller.controlLoginButton();
              },
            ),
            SizedBox(height: 2.h),
            Obx(() {
              return EvrekaTextField(
                hint: "Password",
                showObscureText: !controller.showPassword.value,
                cont: controller.passwordTEC,
                onChanged: (p0) {
                  controller.controlLoginButton();
                },
                onChangedVisibilityFunc: () {
                  controller.showPassword(!controller.showPassword.value);
                },
              );
            })
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return Obx(() {
      return Padding(
        padding: EvrekaDimentions.padding,
        child: EvrekaButton(
          text: "LOGIN",
          buttonEnable: controller.loginButtonEnable.value,
          func: () {
            if (controller.loginFormKey.currentState!.validate()) {
              controller.signInWithEmailAndPassword();
            }
          },
        ),
      );
    });
  }
}
