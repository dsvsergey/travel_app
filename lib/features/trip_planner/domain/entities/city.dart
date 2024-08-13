import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'range.dart';

class City extends Equatable {
  final String id;
  final String name;
  final String country;
  final String countryCode;
  final double latitude;
  final double longitude;
  final Color color;
  final RangeDate? rangeDate;

  const City({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.color,
    this.rangeDate,
  });

  @override
  List<Object?> get props =>
      [id, name, country, countryCode, latitude, longitude, color, rangeDate];
}
