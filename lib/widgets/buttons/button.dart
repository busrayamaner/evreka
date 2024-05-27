import 'package:evreka/globals/colors.dart';
import 'package:evreka/globals/text_styles.dart';
import 'package:flutter/material.dart';

class EvrekaButton extends StatelessWidget {
  const EvrekaButton(
      {super.key,
      required this.text,
      required this.buttonEnable,
      this.color,
      required this.func});
  final String text;
  final bool buttonEnable;
  final Function() func;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonEnable == true ? func : null,
      child: Opacity(
        opacity: buttonEnable == true ? 1 : 0.4,
        child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: color ?? EvrekaColors.green,
              boxShadow: [
                BoxShadow(
                  color: color ?? EvrekaColors.shadowColorGreen,
                  spreadRadius: 1.5,
                  blurRadius: 8,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Center(
                child: Text(
              text,
              style: EvrekaTextStyles.buttonText,
            ))),
      ),
    );
  }
}
