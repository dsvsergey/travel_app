part of 'city_selection_bloc.dart';

class CitySelectionState extends Equatable {
  final List<City> cities;
  final LatLng? selectedLocation;
  final String? error;
  final Map<String, DateTimeRange?> selectedDates;
  final City? selectedCity;

  const CitySelectionState({
    required this.cities,
    this.selectedLocation,
    this.error,
    required this.selectedDates,
    this.selectedCity,
  });

  factory CitySelectionState.initial() =>
      const CitySelectionState(cities: [], selectedDates: {});

  CitySelectionState copyWith({
    List<City>? cities,
    LatLng? selectedLocation,
    String? error,
    Map<String, DateTimeRange?>? selectedDates,
    City? selectedCity,
  }) {
    return CitySelectionState(
        cities: cities ?? this.cities,
        selectedLocation: selectedLocation ?? this.selectedLocation,
        error: error ?? this.error,
        selectedDates: selectedDates ?? this.selectedDates,
        selectedCity: selectedCity ?? this.selectedCity);
  }

  @override
  List<Object?> get props =>
      [cities, selectedLocation, error, selectedDates, selectedCity];
}
