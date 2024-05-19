import 'package:flutter/material.dart';

class BackgroundPattern extends StatelessWidget {
  final Widget child;
  const BackgroundPattern({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: child,
      ),
    );
  }
}
