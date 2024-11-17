
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoader extends StatelessWidget {

  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
        "assets/lottie/bee_loader.json",
    );
  }
}