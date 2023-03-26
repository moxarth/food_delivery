import 'package:flutter/material.dart';
import 'package:front_end/routes.dart';
import 'package:front_end/screens/splash_screen.dart';
import 'package:front_end/screens/tab_page.dart';

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
        primarySwatch: Colors.orange,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.orange.shade100,
          indicatorColor: Colors.orange,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
