import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/localization/app_localizations.dart';
import '../block/city_selection_bloc.dart';
import '../widgets/city_list_overlay.dart';
import '../widgets/city_selection_range_date.dart';

class CitySelectionPage extends StatelessWidget {
  const CitySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CitySelectionView();
  }
}

class CitySelectionView extends StatefulWidget {
  const CitySelectionView({super.key});

  @override
  State<CitySelectionView> createState() => _CitySelectionViewState();
}

class _CitySelectionViewState extends State<CitySelectionView> {
  bool _isOverlayVisible = true;

  void _toggleOverlayVisibility(bool isVisible) {
    setState(() {
      _isOverlayVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(48.8566, 2.3522), // Paris
              initialZoom: 6.0,
              onTap: (tapPosition, point) {
                context.read<CitySelectionBloc>().add(SelectLocation(point));
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              BlocBuilder<CitySelectionBloc, CitySelectionState>(
                builder: (context, state) {
                  if (state.selectedLocation != null) {
                    return MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: state.selectedLocation!,
                          child:
                              const Icon(Icons.location_on, color: Colors.red),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          if (_isOverlayVisible) const CityListOverlay(),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: BlocBuilder<CitySelectionBloc, CitySelectionState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    _toggleOverlayVisibility(false);
                    showBottomSheet(
                      showDragHandle: true,
                      context: context,
                      // isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          width: MediaQuery.of(context).size.width - 10,
                          child: CitySelectionRangeDate(
                            cities: state.cities,
                            selectedDates: state.selectedDates,
                            onCitySelected: (city) {
                              context
                                  .read<CitySelectionBloc>()
                                  .add(SelectCity(city));
                            },
                            onDateSelected: (dates) {
                              context
                                  .read<CitySelectionBloc>()
                                  .add(UpdateDates(dates));
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ).closed.then((_) => _toggleOverlayVisibility(true));
                  },
                  child: Text(l10n.next),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
