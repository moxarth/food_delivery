// ignore_for_file: prefer_const_constructors

import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import 'home_page.dart';
import 'menu_page.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.title});

  static String routeName = '/restaurants';
  final String title;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Restaurant"),
      ),
    );
  }
}
