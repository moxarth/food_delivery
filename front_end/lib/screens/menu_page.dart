import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/screens/order_page.dart';
import 'package:front_end/screens/restaurant_page.dart';
import 'package:front_end/widgets/menu_card.dart';

import '../api.dart';
import '../size_config.dart';
import 'home_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage(
      {super.key,
      required this.title,
      this.restaurantName = "",
      this.restaurantImage = ""});

  static String routeName = '/menu';
  final String title;
  final String restaurantName;
  final String restaurantImage;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List menu = [];
  int total_menu = 0;
  Map<String, dynamic> menu_data = {};

  void update(String key, Map data) {
    menu_data.update(
      key,
      (value) => data,
      ifAbsent: () => data,
    );
  }

  _getMenu(Map<String, dynamic> query) async {
    await Getdata(Uri.http('localhost:5000', 'menu', query)).then((value) {
      setState(() {
        if (query['restaurant'] != '') {
          menu = value[query['restaurant']];
        } else {
          menu = value['Pizza Hut'];
        }
      });
    });
  }

  @override
  void initState() {
    if (widget.restaurantName == '') {
      Map<String, dynamic> query = {'restaurant': 'Pizza Hut'};
      _getMenu(query);
    } else {
      Map<String, dynamic> query = {'restaurant': widget.restaurantName};
      _getMenu(query);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                children: List.generate(
                  menu.length,
                  (index) {
                    var menus = menu[index];
                    return MenuCard(
                      image: menus['menu_image'],
                      name: menus['menu_name'],
                      price: menus['price'],
                      onMenuChanged: ((data) {
                        setState(() {
                          update(data['menu_name'], data);
                          menu_data[data['menu_name']]['menu_image'] =
                              menus['menu_image'];
                        });
                      }),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                for (var value in menu_data.values) {
                  var data = {
                    'name': value['menu_name'],
                    'image_url': value['menu_image'],
                    'price': value['price'].toString(),
                    'quantity': value['count'].toString()
                  };
                  await Postdata(Uri.http('localhost:5000', 'order'), data);
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return OrderPage(
                        order_data: menu_data,
                        title: "My Orders",
                      );
                    },
                  ),
                );
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueGrey,
                  ),
                  margin: const EdgeInsets.only(bottom: 3.0),
                  width: 150.0,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(
                        EvaIcons.doneAll,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
