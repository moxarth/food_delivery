import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

typedef void MapCallBack(Map<String, dynamic> menu_data);

class MenuCard extends StatefulWidget {
  MenuCard(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.onMenuChanged});
  String image;
  String name;
  int price;
  final MapCallBack onMenuChanged;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int menu_count = 0;

  @override
  Widget build(BuildContext context) {
    int price = widget.price;
    return Container(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
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
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              width: 200.0,
              height: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    color: Colors.white70,
                    child: Text(
                      'Rs. $price',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    color: Colors.white70,
                    width: 90.0,
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              menu_count += 1;
                              widget.onMenuChanged({
                                'menu_name': widget.name,
                                'count': menu_count,
                                'price': widget.price * menu_count,
                              });
                            });
                          },
                          child: const Icon(
                            EvaIcons.plus,
                            color: Colors.orange,
                          ),
                        ),
                        Text('$menu_count'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (menu_count > 0) {
                                menu_count -= 1;
                              }
                              widget.onMenuChanged({
                                'menu_name': widget.name,
                                'count': menu_count,
                                'price': widget.price * menu_count,
                              });
                            });
                          },
                          child: const Icon(
                            EvaIcons.minus,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
