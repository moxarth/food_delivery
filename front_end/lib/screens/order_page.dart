import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/screens/home_page.dart';
import 'package:uuid/uuid.dart';

import '../api.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key, required this.order_data, required this.title});
  Map<String, dynamic> order_data = {};
  static String routeName = '/order';
  String title;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int total = 0;

  Future<void> _dialogBuilder(BuildContext context, int total) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment'),
          content: Text('Your total amount is ${total.toString()}\n'
              'Are you sure to do payment?'),
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
              child: const Text('Pay'),
              onPressed: () async {
                Map<String, String> data = {
                  'order': Uuid().v1().toString(),
                  'amount': total.toString(),
                };
                await Deletedata(Uri.http('localhost:5000', 'order'));
                var response =
                    await Postdata(Uri.http('localhost:5000', 'payment'), data);
                if (response['success'] == true) {
                  Fluttertoast.showToast(
                      msg: 'Payment Done of Rs. ${total.toString()}');
                  Navigator.popAndPushNamed(context, HomePage.routeName);
                } else {
                  Fluttertoast.showToast(msg: 'Payment Failed!');
                }
              },
            ),
          ],
        );
      },
    );
  }

  List? orders = [
    {
      "name": "Vegan Mushroom Stroganoff",
      "image_url":
          "https://c.ndtvimg.com/2020-09/if4pp5j8_vegetarian_625x300_30_September_20.jpg",
      "price": 450,
      "quantity": 1
    }
  ];

  _get_data() async {
    await Getdata(Uri.http('localhost:5000', 'order')).then((value) {
      setState(() {
        orders = value;
      });
    }).onError((error, stackTrace) {
      setState(() {
        orders = [
          {
            "name": "Vegan Mushroom Stroganoff",
            "image_url":
                "https://c.ndtvimg.com/2020-09/if4pp5j8_vegetarian_625x300_30_September_20.jpg",
            "price": 450,
            "quantity": 1
          }
        ];
      });
    });
  }

  @override
  void initState() {
    _get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          color: Colors.black12,
          width: 500.0,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: orders!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(orders![index]['name']),
                        trailing: Text(
                          'Rs. ${orders![index]["price"].toString()} (${orders![index]["quantity"]})',
                        ),
                        leading: Image.network(
                          orders![index]["image_url"],
                          fit: BoxFit.cover,
                          height: 50.0,
                          width: 70.0,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => _dialogBuilder(context, total),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8.0)),
                    width: 250.0,
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.payment,
                          color: Colors.white,
                        ),
                        Text(
                          "Proceed to Pay",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
