import 'package:email_generator/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: Image.asset(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                fit: BoxFit.cover,
                backgroundImagePath),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(height: 100, "./assets/lottie/loading.json"),
              Text(
                "Loading...",
                style: TextStyle(color: Colors.white),
              )
            ],
          )),
        ],
      ),
    );
  }
}
