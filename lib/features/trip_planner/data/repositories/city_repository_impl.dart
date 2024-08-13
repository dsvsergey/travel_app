import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/city_repository.dart';
import '../datasources/city_local_data_source.dart';
import '../models/city_model.dart';

@Singleton(as: CityRepository)
class CityRepositoryImpl implements CityRepository {
  final CityLocalDataSource localDataSource;

  CityRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final localCities = await localDataSource.getLastCities();
      return Right(localCities);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCity(City city) async {
    try {
      final cityModel = city.toModel();

      final currentCities = await localDataSource.getLastCities();

      currentCities.add(cityModel);

      await localDataSource.cacheCities(currentCities);

      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeCity(String cityId) async {
    try {
      final currentCities = await localDataSource.getLastCities();

      currentCities.removeWhere((city) => city.id == cityId);

      await localDataSource.cacheCities(currentCities);

      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
