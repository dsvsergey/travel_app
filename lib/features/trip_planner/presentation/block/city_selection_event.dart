part of 'city_selection_bloc.dart';

abstract class CitySelectionEvent extends Equatable {
  const CitySelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadCities extends CitySelectionEvent {}

class SelectLocation extends CitySelectionEvent {
  final LatLng location;

  const SelectLocation(this.location);

  @override
  List<Object> get props => [location];
}

class AddSelectedCity extends CitySelectionEvent {}

class RemoveSelectedCity extends CitySelectionEvent {
  final String cityId;

  const RemoveSelectedCity(this.cityId);

  @override
  List<Object> get props => [cityId];
}
