import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/screens/home_page.dart';
import 'package:front_end/screens/login_page.dart';
import 'package:front_end/screens/register_page.dart';
import 'package:front_end/screens/tab_page.dart';
import 'package:front_end/widgets/custom_input.dart';
import 'package:lottie/lottie.dart';

import '../api.dart';
import '../widgets/custom_buttom.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  static String routeName = '/logout';

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  bool? isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400.0,
              width: 400.0,
              child: LottieBuilder.network(
                'https://assets3.lottiefiles.com/packages/lf20_llgwnod7.json',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 400.0,
              child: CustomButton(
                text: 'Logout',
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.popAndPushNamed(context, LoginPage.routeName);
                },
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
