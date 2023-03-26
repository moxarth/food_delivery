import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData? _mediaQuery;
  static double? width;
  static double? height;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    width = _mediaQuery!.size.width;
    height = _mediaQuery!.size.height;
    orientation = _mediaQuery!.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.height!;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.width!;
  return (inputWidth / 812.0) * screenWidth;
}
