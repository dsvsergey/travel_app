import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/city_model.dart';

abstract class CityLocalDataSource {
  Future<List<CityModel>> getLastCities();

  Future<void> cacheCities(List<CityModel> citiesToCache);
}

const cachedCities = 'CACHED_CITIES';

@Singleton(as: CityLocalDataSource)
class CityLocalDataSourceImpl implements CityLocalDataSource {
  late Future<SharedPreferences> _sharedPreferences;

  @factoryMethod
  CityLocalDataSourceImpl() {
    _sharedPreferences = SharedPreferences.getInstance();
  }

  @override
  Future<List<CityModel>> getLastCities() => _sharedPreferences
          .then((value) => value.getString(cachedCities))
          .then((jsonString) {
        if (jsonString != null) {
          return Future.value(json
              .decode(jsonString)
              .map<CityModel>((json) => CityModel.fromJson(json))
              .toList());
        } else {
          return Future.value([]);
        }
      });

  @override
  Future<void> cacheCities(List<CityModel> citiesToCache) =>
      _sharedPreferences.then((value) => value.setString(cachedCities,
          json.encode(citiesToCache.map((city) => city.toJson()).toList())));
}
