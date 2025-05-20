import 'package:flutter/cupertino.dart';

double height = 0.0;
double width = 0.0;

extension Size on int {
  double he() {
    return (this / 926) * height;
  }

  double we() {
    return (this / 428) * width;
  }

  SizedBox getH() {
    return SizedBox(
      height: (this / 926) * height,
    );
  }

  SizedBox getW() {
    return SizedBox(
      width: (this / 428) * width,
    );
  }
}
