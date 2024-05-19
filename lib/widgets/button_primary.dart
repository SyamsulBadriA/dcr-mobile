import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final double? width;
  final String title;
  final Function() onTap;
  final bool isEnabled;
  final double? height;
  final Widget? titleWidget;

  const ButtonPrimary({
    super.key,
    this.width,
    required this.title,
    required this.onTap,
    this.isEnabled = true,
    this.height,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : () {},
      child: Container(
        height: height ?? 57,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: !isEnabled ? Colors.black38 : null,
          gradient: !isEnabled
              ? null
              : LinearGradient(
                  begin: const Alignment(0.99, -0.15),
                  end: const Alignment(-0.99, 0.15),
                  colors: [
                    Theme.of(context).colorScheme.tertiary.withOpacity(1),
                    Theme.of(context).colorScheme.primary,
                  ],
                ),
        ),
        child: Center(
          child: titleWidget ??
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}
