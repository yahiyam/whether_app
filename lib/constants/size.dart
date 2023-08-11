import 'package:flutter/material.dart';

class AppScreen {
  static late Size size;
  static double width([double percentage = 100]) {
    return size.width * percentage / 100;
  }

  static double height([double percentage = 100]) {
    return size.height * percentage / 100;
  }
}
