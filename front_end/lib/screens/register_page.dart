import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/widgets/custom_input.dart';

import '../api.dart';
import '../widgets/custom_buttom.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static String routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          "Register",
          textAlign: TextAlign.center,
        ),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '', password = '', confirmPassword = '';
  FocusNode? _passwordFocusNode;
  bool? isLoading;
  bool isForgetPasswordChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                "Register Account",
                style: TextStyle(
                  fontSize: (35),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: (25),
              ),
              const Text(
                "complete your details",
                style: TextStyle(fontSize: (18)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: (60.0),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: (35),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: (25),
                      ),
                      CustomInput(
                        obscuredText: false,
                        validator: (value) {
                          final bool isValidate =
                              EmailValidator.validate(value!);
                          if (value.isEmpty) {
                            return 'Please enter the email';
                          } else if (!isValidate) {
                            return 'please enter valid email';
                          }
                        },
                        hintText: "Enter your Email",
                        textInputAction: TextInputAction.next,
                        label: "Email",
                        iconData: const Icon(
                          EvaIcons.emailOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          email = value!;
                        },
                        onSubmitted: (value) {
                          _passwordFocusNode!.requestFocus();
                        },
                      ),
                      const SizedBox(
                        height: (20),
                      ),
                      CustomInput(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Enter the 6+ character long password';
                          }
                        },
                        focusNode: _passwordFocusNode,
                        hintText: "Enter your Password",
                        label: "Password",
                        iconData: const Icon(
                          EvaIcons.lockOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          password = value!;
                        },
                        onSubmitted: (value) {
                          password = value!;
                        },
                        obscuredText: true,
                        textInputAction: TextInputAction.none,
                      ),
                      const SizedBox(
                        height: (20),
                      ),
                      CustomInput(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'enter the 6+ character long password';
                          } else if (password != confirmPassword) {
                            return 'password does not match';
                          }
                        },
                        hintText: "Re-enter your Password",
                        label: "Confirm Password",
                        iconData: const Icon(
                          EvaIcons.lockOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          confirmPassword = value!;
                        },
                        onSubmitted: (value) {
                          confirmPassword = value!;
                        },
                        obscuredText: true,
                        textInputAction: TextInputAction.none,
                      ),
                      const SizedBox(
                        height: (20),
                      ),
                      CustomButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            Map<String, dynamic> form_Data = {
                              'email': email,
                              'password': password,
                            };
                            var response = await Postdata(
                                Uri.http('localhost:5000', 'register'), form_Data);
                            if (response['status'] == 200) {
                              Fluttertoast.showToast(msg: response['message']);
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacementNamed(
                                  context, HomePage.routeName);
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              Fluttertoast.showToast(msg: response['message']);
                            }
                          } else {
                            Fluttertoast.showToast(msg: "ERROR OCCURRED");
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        text: "Continue",
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: (175.0),
              ),
              const Divider(
                thickness: 1.0,
                height: (2.0),
                color: Colors.black26,
              ),
              const SizedBox(
                height: (15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ",
                    style: TextStyle(
                      fontSize: (18.0),
                    ),
                  ),
                  const SizedBox(
                    width: (8.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        LoginPage.routeName,
                      );
                    },
                    child: Text(
                      "Go to Login",
                      style: TextStyle(
                        fontSize: (18.0),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: (15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
