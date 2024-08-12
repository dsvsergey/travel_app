import 'package:equatable/equatable.dart';

import '../../data/models/city_model.dart';

class City extends Equatable {
  final String id;
  final String name;
  final String country;
  final String countryCode;
  final double latitude;
  final double longitude;

  const City({
    required this.id,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [id, name, country, latitude, longitude];
}

extension CityModelX on City {
  CityModel toModel() => CityModel(
        id: id,
        name: name,
        country: country,
        latitude: latitude,
        longitude: longitude,
        countryCode: countryCode,
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
      );
}
