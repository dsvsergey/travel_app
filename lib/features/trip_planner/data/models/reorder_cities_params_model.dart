import 'package:equatable/equatable.dart';

import '../../domain/entities/reorder_cities_params.dart';
import 'city_model.dart';

class ReorderCitiesParamsModel extends Equatable {
  final int newIndex;
  final int oldIndex;
  final List<CityModel> cities;

  const ReorderCitiesParamsModel({
    required this.newIndex,
    required this.oldIndex,
    required this.cities,
  });

  factory ReorderCitiesParamsModel.fromEntity(ReorderCitiesParams params) {
    return ReorderCitiesParamsModel(
      oldIndex: params.oldIndex,
      newIndex: params.newIndex,
      cities: params.cities.map((city) => city.toModel()).toList(),
    );
  }

  @override
  List<Object?> get props => [newIndex, oldIndex, cities];
}

extension ReorderCitiesParamsModelX on ReorderCitiesParamsModel {
  ReorderCitiesParams toEntity() {
    return ReorderCitiesParams(
      oldIndex: oldIndex,
      newIndex: newIndex,
      cities: cities.map((cityModel) => cityModel.toEntity()).toList(),
    );
  }
}

extension ReorderCitiesParamsX on ReorderCitiesParams {
  ReorderCitiesParamsModel toModel() {
    return ReorderCitiesParamsModel(
      oldIndex: oldIndex,
      newIndex: newIndex,
      cities: cities.map((city) => city.toModel()).toList(),
    );
  }
}
