import 'package:flutter/material.dart';
import 'package:front_end/routes.dart';

import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: LoginPage.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
