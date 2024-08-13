import 'package:flutter/material.dart';

import '../../../../core/util/color_utils.dart';
import '../../domain/entities/city.dart';
import 'range_date_model.dart';

class CityModel extends City {
  const CityModel({
    required super.id,
    required super.name,
    required super.country,
    required super.countryCode,
    required super.latitude,
    required super.longitude,
    required super.color,
    super.rangeDate,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      countryCode: json['country_code'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      color: json['color'] != null
          ? Color(json['color'])
          : ColorUtils.generatePastelColor(),
      rangeDate: json['range_date'] != null
          ? RangeDateModel.fromJson(json['range_date']).toEntity()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'country_code': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'color': color.value,
      'range_date': rangeDate?.toModel().toJson(),
    };
  }
}

extension CityModelX on City {
  CityModel toModel() => CityModel(
        id: id,
        name: name,
        country: country,
        latitude: latitude,
        longitude: longitude,
        countryCode: countryCode,
        color: color,
        rangeDate: rangeDate,
      );
}

extension CityX on CityModel {
  City toEntity() => City(
        id: id,
        name: name,
        country: country,
        latitude: latitude,
        longitude: longitude,
        countryCode: countryCode,
        color: color,
        rangeDate: rangeDate,
      );
}
