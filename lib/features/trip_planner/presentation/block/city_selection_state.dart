part of 'city_selection_bloc.dart';

class CitySelectionState extends Equatable {
  final List<City> cities;
  final LatLng? selectedLocation;
  final String? error;

  const CitySelectionState({
    required this.cities,
    this.selectedLocation,
    this.error,
  });

  factory CitySelectionState.initial() => const CitySelectionState(cities: []);

  CitySelectionState copyWith({
    List<City>? cities,
    LatLng? selectedLocation,
    String? error,
  }) {
    return CitySelectionState(
      cities: cities ?? this.cities,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [cities, selectedLocation, error];
}
