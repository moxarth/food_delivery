import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../size_config.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.popAndPushNamed(context, LoginPage.routeName);
      // Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: 500.0,
          height: 500.0,
          child: Lottie.asset(
            "assets/animations/delivery-boy.json",
          ),
        ),
      ),
    );
  }
}
