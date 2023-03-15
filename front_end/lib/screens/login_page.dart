import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_end/screens/register_page.dart';
import 'package:front_end/widgets/custom_input.dart';

import '../widgets/custom_buttom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? _passwordFocusNode;
  bool? isLoading;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 75.0,
              ),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              const Text(
                "sign in with email and password",
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60.0,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35.0,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25.0,
                      ),
                      CustomInput(
                        validator: (value) {
                          final bool isValidate =
                              EmailValidator.validate(value!);
                          if (value.isEmpty) {
                            return 'Please enter the email';
                          } else if (!isValidate) {
                            return 'please enter valid email';
                          }
                        },
                        hintText: 'Email',
                        label: 'Enter your email',
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
                        obscuredText: false,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomInput(
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Enter the 6+ character long password';
                          }
                        },
                        focusNode: _passwordFocusNode,
                        hintText: "Enter the Password",
                        label: "Password",
                        iconData: const Icon(
                          EvaIcons.lockOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          password = value!;
                        },
                        obscuredText: true,
                        textInputAction: TextInputAction.none,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            Fluttertoast.showToast(msg: "SUCCESS");
                            Navigator.pushReplacementNamed(context, RegisterPage.routeName);
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            Fluttertoast.showToast(msg: "ERROR OCCURRED");
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        text: "Login",
                        isLoading: isLoading,
                      ),
                    ],
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
