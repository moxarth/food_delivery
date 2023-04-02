import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/widgets/custom_buttom.dart';

import '../api.dart';
import '../widgets/custom_input.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});
  static String routeName = '/add';

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  String restName = '';
  String imageURL = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Restaurant",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              CustomInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the restaurant name';
                  }
                },
                hintText: 'Enter your Restaurant Name',
                label: 'Restaurant Name',
                iconData: const Icon(
                  EvaIcons.emailOutline,
                  color: Colors.orange,
                ),
                onChanged: (value) {
                  restName = value!;
                },
                obscuredText: false,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the image url';
                  }
                },
                hintText: 'Enter your image url',
                label: 'Image URL',
                iconData: const Icon(
                  EvaIcons.emailOutline,
                  color: Colors.orange,
                ),
                onChanged: (value) {
                  imageURL = value!;
                },
                obscuredText: false,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                isLoading: false,
                text: 'Add',
                onPressed: () async {
                  Map<String, String> data = {
                    'name': restName,
                    'image_url': imageURL,
                    'rating': "0"
                  };
                  var response =
                      await Postdata(Uri.http('localhost:5000', 'rests'), data);
                  if (response['success'] == true) {
                    Fluttertoast.showToast(msg: 'Added a restaurant $restName');
                    setState(() {
                      restName = '';
                      imageURL = '';
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Failed to add a new Restaurant $restName');
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                isLoading: false,
                text: 'Back to Restaurants',
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
