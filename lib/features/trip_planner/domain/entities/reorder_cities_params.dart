import 'package:equatable/equatable.dart';
import 'city.dart';

class ReorderCitiesParams extends Equatable {
  final int oldIndex;
  final int newIndex;
  final List<City> cities;

  const ReorderCitiesParams({
    required this.oldIndex,
    required this.newIndex,
    required this.cities,
  });

  @override
  List<Object> get props => [oldIndex, newIndex, cities];
}
