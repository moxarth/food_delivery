import 'dart:ui';
import 'dart:io';

import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/api.dart';
import 'package:front_end/screens/menu_page.dart';
import 'package:front_end/screens/restaurant_page.dart';
import 'package:front_end/size_config.dart';
import 'package:front_end/widgets/custom_input.dart';
import 'package:http/http.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';

import '../widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  static String routeName = '/home';
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List restaurants = [];

  _setRestaurants() async {
    await Getdata(Uri.http(
      'localhost:5001',
      'rests',
    )).then(
      (value) {
        setState(() {
          restaurants = value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _setRestaurants();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    String restName = "";
    String imageUrl = "";

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Restaurant'),
          content: Container(
            height: 300.0,
            width: 500.0,
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                CustomInput(
                  obscuredText: false,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter a restaurant name',
                  label: 'Restaurant Name',
                  iconData: const Icon(Icons.restaurant),
                  onChanged: (value) {
                    restName = value!;
                  },
                ),
                const SizedBox(
                  height: 18.0,
                ),
                CustomInput(
                  obscuredText: false,
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter a restaurant image url',
                  label: 'Image URL',
                  iconData: const Icon(Icons.image),
                  onChanged: (value) {
                    imageUrl = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Add'),
              onPressed: () async {
                Map<String, String> data = {
                  'name': restName,
                  'image_url': imageUrl,
                  'rating': "0"
                };
                var response = await Postdata(
                    Uri.http('localhost:5000', 'restaurant'), data);
                if (response['success'] == true) {
                  Fluttertoast.showToast(msg: 'Added a restaurant $restName');
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                      msg: 'Failed to add a new Restaurant $restName');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _dialogBuilder(context);
        },
        child: Container(
          color: Colors.blueGrey,
          width: 200.0,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                'Add Restaurant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          shrinkWrap: true,
          children: List.generate(
            restaurants.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MenuPage(
                        title: 'Menu',
                        restaurantName: restaurants[index]['name'],
                        restaurantImage: restaurants[index]['image']);
                  }));
                },
                child: Container(
                  // width: 200.0,
                  // height: 100.0,
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          // height: 100.0,
                          // width: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(restaurants[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          decoration: const BoxDecoration(
                            color: Colors.white70,
                          ),
                          height: 30.0,
                          width: 250.0,
                          child: Text(
                            restaurants[index]['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
