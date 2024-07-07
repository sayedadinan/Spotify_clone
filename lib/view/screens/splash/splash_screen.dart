import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netflix/view/screens/Home_screen/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image.asset(
        'lib/assets/spotify icon.png',
      )),
    );
  }
}
