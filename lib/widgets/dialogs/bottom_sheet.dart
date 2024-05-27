import 'package:evreka/globals/colors.dart';
import 'package:evreka/globals/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomSnackBar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
          decoration: const BoxDecoration(
            color: EvrekaColors.lightColor,
            boxShadow: [
              BoxShadow(
                color: EvrekaColors.shadowColor,
                spreadRadius: 1.5,
                blurRadius: 8,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: 15.w,
                  child: Image.asset("assets/Error.png"),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  padding: EdgeInsets.only(left: 1.w),
                  child: Text(
                    text,
                    maxLines: 3,
                    style: EvrekaTextStyles.t1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
