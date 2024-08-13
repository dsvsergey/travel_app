import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtils {
  static Color generatePastelColor() {
    final random = Random();

    int r = 200 + random.nextInt(56);
    int g = 200 + random.nextInt(56);
    int b = 200 + random.nextInt(56);

    return Color.fromRGBO(r, g, b, 1);
  }
}
