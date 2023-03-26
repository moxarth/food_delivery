import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/screens/home_page.dart';
import 'package:front_end/screens/logout_page.dart';
import 'package:front_end/screens/menu_page.dart';
import 'package:front_end/screens/order_page.dart';
import 'package:front_end/screens/restaurant_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: <Widget>[
          const HomePage(
            title: "Welcome Foodie!",
          ),
          const MenuPage(
            title: "Menu",
          ),
          OrderPage(
            title: "My Orders",
            order_data: {},
          ),
          const LogoutPage()
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (int index) {
          setState(() {
            selectedTab = index;
          });
          Fluttertoast.showToast(msg: selectedTab.toString());
        },
        animationDuration: const Duration(seconds: 2),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Dashboard',
            selectedIcon: Icon(Icons.home_filled),
            tooltip: 'Navigate to the Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Menu',
            selectedIcon: Icon(Icons.restaurant_menu_outlined),
          ),
          NavigationDestination(
            icon: Icon(Icons.dinner_dining_outlined),
            selectedIcon: Icon(Icons.dining_outlined),
            label: 'Order',
          ),
          NavigationDestination(
            icon: Icon(Icons.exit_to_app),
            selectedIcon: Icon(Icons.logout_rounded),
            label: 'Logout',
          )
        ],
      ),
    );
  }
}
