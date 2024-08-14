import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/color_utils.dart';
import '../../data/datasources/geocoding_service.dart';
import '../../domain/entities/city.dart';
import '../../domain/usecases/add_city.dart';
import '../../domain/usecases/get_cities.dart';
import '../../domain/usecases/remove_city.dart';

part 'city_selection_event.dart';
part 'city_selection_state.dart';

@injectable
class CitySelectionBloc extends Bloc<CitySelectionEvent, CitySelectionState> {
  final GetCities getCities;
  final AddCity addCity;
  final RemoveCity removeCity;

  CitySelectionBloc({
    required this.getCities,
    required this.addCity,
    required this.removeCity,
  }) : super(CitySelectionState.initial()) {
    on<LoadCities>(_onLoadCities);
    on<SelectLocation>(_onSelectLocation);
    on<AddSelectedCity>(_onAddSelectedCity);
    on<RemoveSelectedCity>(_onRemoveCity);
    on<UpdateDates>(_onUpdateDates);
    on<SelectCity>(_onSelectCity);
  }

  void _onLoadCities(LoadCities event, Emitter<CitySelectionState> emit) async {
    final result = await getCities(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(error: failure.toString())),
      (cities) => emit(state.copyWith(cities: cities)),
    );
  }

  void _onSelectLocation(
      SelectLocation event, Emitter<CitySelectionState> emit) {
    emit(state.copyWith(selectedLocation: event.location));
  }

  void _onAddSelectedCity(
    AddSelectedCity event,
    Emitter<CitySelectionState> emit,
  ) async {
    if (state.selectedLocation != null) {
      try {
        final locationInfo = await GeocodingService.getLocationInfo(
            state.selectedLocation!.latitude,
            state.selectedLocation!.longitude);
        final newCity = City(
          id: DateTime.now().toString(),
          name: locationInfo.cityName,
          country: locationInfo.country,
          countryCode: locationInfo.countryCode,
          latitude: state.selectedLocation!.latitude,
          longitude: state.selectedLocation!.longitude,
          color: ColorUtils.generateVibrantColor(),
        );
        final result = await addCity(newCity);
        result.fold(
          (failure) => emit(state.copyWith(error: failure.toString())),
          (_) => add(LoadCities()),
        );
      } catch (e) {
        emit(state.copyWith(error: 'Failed to get location info: $e'));
      }
    }
  }

  void _onRemoveCity(
      RemoveSelectedCity event, Emitter<CitySelectionState> emit) async {
    final result = await removeCity(event.cityId);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.toString())),
      (_) => add(LoadCities()),
    );
  }

  void _onUpdateDates(UpdateDates event, Emitter<CitySelectionState> emit) {
    emit(state.copyWith(selectedDates: event.dates));
  }

  void _onSelectCity(SelectCity event, Emitter<CitySelectionState> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }
}
