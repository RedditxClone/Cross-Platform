import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late double width;

  Responsive(this.context) {
    width = MediaQuery.of(context).size.width;
  }
  bool isSmallSizedScreen() {
    return MediaQuery.of(context).size.width < 600 ? true : false;
  }

  bool isMediumSizedScreen() {
    return MediaQuery.of(context).size.width >= 600 &&
            MediaQuery.of(context).size.width < 1000
        ? true
        : false;
  }

  bool isLargeSizedScreen() {
    return MediaQuery.of(context).size.width >= 1000 &&
            MediaQuery.of(context).size.width < 1300
        ? true
        : false;
  }

  bool isXLargeSizedScreen() {
    return MediaQuery.of(context).size.width >= 1300 ? true : false;
  }
}
