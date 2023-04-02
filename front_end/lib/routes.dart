import 'package:flutter/material.dart';
import 'package:front_end/screens/add_restaurant.dart';
import 'package:front_end/screens/home_page.dart';
import 'package:front_end/screens/login_page.dart';
import 'package:front_end/screens/menu_page.dart';
import 'package:front_end/screens/order_page.dart';
import 'package:front_end/screens/register_page.dart';
import 'package:front_end/screens/restaurant_page.dart';
import 'package:front_end/screens/splash_screen.dart';
import 'package:front_end/screens/tab_page.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => const LoginPage(),
  SplashScreen.routeName: (context) => SplashScreen(),
  RegisterPage.routeName: (context) => const RegisterPage(),
  HomePage.routeName: (context) => const HomePage(title: "Welcome Foodie!"),
  MenuPage.routeName: (context) => const MenuPage(
        title: "Your Orders",
      ),
  RestaurantPage.routeName: (context) =>
      const RestaurantPage(title: "Restaurants"),
  TabPage.routeName: (context) => const TabPage(),
  AddRestaurant.routeName: (context) => AddRestaurant(),
  OrderPage.routeName: (context) => OrderPage(
        title: "My Orders",
        order_data: {},
      ),
};
