import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static Color generateVibrantColor() {
    final random = Random();

    int r = 200 + random.nextInt(101);
    int g = 200 + random.nextInt(101);
    int b = 200 + random.nextInt(101);

    return Color.fromRGBO(r, g, b, 1);
  }
}
