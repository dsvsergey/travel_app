import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/city_repository.dart';

@LazySingleton()
class RemoveCity implements UseCase<void, String> {
  final CityRepository repository;

  RemoveCity(this.repository);

  @override
  Future<Either<Failure, void>> call(String cityId) async {
    return await repository.removeCity(cityId);
  }
}
