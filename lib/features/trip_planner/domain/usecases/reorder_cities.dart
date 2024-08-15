import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city.dart';
import '../entities/reorder_cities_params.dart';
import '../repositories/city_repository.dart';

@LazySingleton()
class ReorderCities implements UseCase<List<City>, ReorderCitiesParams> {
  final CityRepository repository;

  ReorderCities(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(ReorderCitiesParams params) async {
    final updatedCities = List<City>.from(params.cities);
    final city = updatedCities.removeAt(params.oldIndex);
    updatedCities.insert(params.newIndex, city);

    for (int i = 0; i < updatedCities.length; i++) {
      updatedCities[i] = updatedCities[i].copyWith(index: i);
    }

    return repository.updateCities(updatedCities);
  }
}
