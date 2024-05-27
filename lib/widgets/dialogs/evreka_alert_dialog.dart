import 'package:evreka/globals/colors.dart';
import 'package:evreka/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<bool?> showAppAlertDialog({
  required String alertDialogTitle,
  required String alertDialogContent,
  bool? barrierDismissible,
  String? okButtonText,
  Function()? okButtonOnPressed,
  String? cancelButtonText,
  Function()? cancelButtonOnPressed,
  Color? barrierColor,
}) async {
  // If has a dialog, close it
  if (Get.isDialogOpen!) {
    Get.back();
  }

  return Get.dialog<bool?>(
    CustomDialog(
      alertDialogTitle: alertDialogTitle,
      alertDialogContent: alertDialogContent,
      okButtonText: okButtonText ?? "",
      cancelButtonOnPressed: cancelButtonOnPressed ?? () {},
      cancelButtonText: cancelButtonText ?? "",
      okButtonOnPressed: okButtonOnPressed ??
          () {
            Get.back(result: true);
          },
    ),
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible ?? true,
  );
}

class CustomDialog extends StatelessWidget {
  final String? alertDialogTitle;
  final String alertDialogContent;
  final String okButtonText;
  final String cancelButtonText;
  final VoidCallback okButtonOnPressed;
  final VoidCallback cancelButtonOnPressed;
  const CustomDialog({
    super.key,
    this.alertDialogTitle,
    required this.alertDialogContent,
    required this.okButtonText,
    required this.cancelButtonText,
    required this.okButtonOnPressed,
    required this.cancelButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(8),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      surfaceTintColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                alertDialogTitle ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                alertDialogContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: EvrekaButton(
                      func: okButtonOnPressed,
                      text: okButtonText,
                      buttonEnable: true,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: EvrekaButton(
                      func: cancelButtonOnPressed,
                      text: cancelButtonText,
                      buttonEnable: true,
                      color: EvrekaColors.errorColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
