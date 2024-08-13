import 'package:flutter/material.dart';

class RangeDate {
  DateTime start;
  DateTime end;
  Color? startColor;
  Color? endColor;
  Color? textColor;
  Widget? icon;
  String toolTipArMessage;
  String toolTipEnMessage;

  RangeDate({
    required this.start,
    required this.end,
    this.startColor,
    this.endColor,
    this.textColor,
    this.icon,
    this.toolTipEnMessage = '',
    this.toolTipArMessage = '',
  });
}
