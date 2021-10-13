import 'package:flutter/material.dart';

class HYSizeFit {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double rpx;
  static late double px;

  static void initialize(BuildContext context, {double standardWidth = 750}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    rpx = screenWidth / standardWidth;
    px = screenWidth / standardWidth * 2;
  }

  static double setPx(double size) {
    return HYSizeFit.rpx * size * 2;
  }

  static double setRpx(double size) {
    return HYSizeFit.rpx * size;
  }

  static double setHeight(double height) {
    return HYSizeFit.screenHeight / height;
  }

  static double setWidth(double width) {
    return HYSizeFit.screenHeight / width;
  }
}
