import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double getScreenWidth() => Get.width;

  static double getScreenHeight() => Get.height;

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 60);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 80, vertical: 80);
    } else {
      return const EdgeInsets.symmetric(horizontal: 100, vertical: 100);
    }
  }
}
