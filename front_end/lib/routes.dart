import 'package:flutter/material.dart';
import 'package:front_end/screens/home_page.dart';
import 'package:front_end/screens/login_page.dart';
import 'package:front_end/screens/register_page.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  HomePage.routeName: (context) => HomePage(),
};
