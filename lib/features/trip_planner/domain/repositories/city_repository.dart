import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/city.dart';

abstract class CityRepository {
  Future<Either<Failure, List<City>>> getCities();
  Future<Either<Failure, void>> addCity(City city);
  Future<Either<Failure, void>> removeCity(String cityId);
}
