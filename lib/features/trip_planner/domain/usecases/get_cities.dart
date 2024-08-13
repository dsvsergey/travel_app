import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city.dart';
import '../repositories/city_repository.dart';

@LazySingleton()
class GetCities implements UseCase<List<City>, NoParams> {
  final CityRepository repository;

  GetCities(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return await repository.getCities();
  }
}
