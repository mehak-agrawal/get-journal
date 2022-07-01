import 'package:flutter/material.dart';

class SizeHelper {
  final BuildContext context;
  late Size screenSize;

  SizeHelper(this.context) {
    screenSize = MediaQuery.of(context).size;
  }

  Size get size => screenSize;
  double get height => screenSize.height;
  double get width => screenSize.width;
}
