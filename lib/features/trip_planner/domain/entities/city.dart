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
  final int? index;

  const City({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.color,
    this.rangeDate,
    this.index,
  });

  City copyWith({
    String? id,
    String? name,
    String? country,
    String? countryCode,
    double? latitude,
    double? longitude,
    Color? color,
    RangeDate? rangeDate,
    int? index,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      color: color ?? this.color,
      rangeDate: rangeDate ?? this.rangeDate,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        countryCode,
        latitude,
        longitude,
        color,
        rangeDate,
        index
      ];
}
