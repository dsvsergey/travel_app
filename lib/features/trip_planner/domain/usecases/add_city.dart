import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city.dart';
import '../repositories/city_repository.dart';

@LazySingleton()
class AddCity implements UseCase<void, City> {
  final CityRepository repository;

  AddCity(this.repository);

  @override
  Future<Either<Failure, void>> call(City city) async {
    return await repository.addCity(city);
  }
}
