import 'package:flutter/material.dart';

class CustomOutlinedButtoncomite extends StatelessWidget {
  const CustomOutlinedButtoncomite({
    super.key,
    required this.onTap,
    this.outlinedColor,
    this.childWidget,
    this.title,
    this.titleColor,
  });
  final Function() onTap;
  final Color? outlinedColor;
  final Widget? childWidget;
  final String? title;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 57,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.7,
            color: outlinedColor ?? const Color(0xFF000000),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: childWidget ??
            Center(
              child: Text(
                title ?? 'Outlined Button',
                style: TextStyle(
                  fontSize: 16,
                  color: titleColor,
                ),
              ),
            ),
      ),
    );
  }
}
