import 'package:evreka/globals/assets.dart';
import 'package:evreka/globals/colors.dart';
import 'package:evreka/globals/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EvrekaTextField extends StatelessWidget {
  const EvrekaTextField({
    super.key,
    required this.hint,
    this.showObscureText,
    this.onChanged,
    this.onChangedVisibilityFunc,
    required this.cont,
  });
  final String hint;
  final bool? showObscureText;
  final TextEditingController cont;
  final Function(String)? onChanged;
  final Function()? onChangedVisibilityFunc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cont,
      onTapOutside: (final PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: EvrekaTextStyles.t1,
      onChanged: onChanged,
      obscureText:
          (showObscureText == null || showObscureText == false) ? false : true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill this field';
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: (showObscureText != null)
            ? GestureDetector(
                onTap: onChangedVisibilityFunc != null
                    ? onChangedVisibilityFunc!
                    : () {},
                child: Icon(
                  showObscureText == true
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                  color: showObscureText == true
                      ? Colors.grey
                      : EvrekaColors.yellow,
                  size: 20.sp,
                ))
            : GestureDetector(
                onTap: () {
                  cont.clear();
                },
                child: Image.asset(EvrekaAssets.clear),
              ),
        labelStyle: EvrekaTextStyles.inputBoxLabelFilled,
        labelText: hint,
        focusColor: EvrekaColors.yellow,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: EvrekaColors.shadowColor)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: EvrekaColors.yellow)),
        fillColor: EvrekaColors.shadowColor,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: EvrekaTextStyles.inputBoxLabelError,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: EvrekaColors.errorColor,
          ),
        ),
      ),
    );
  }
}
