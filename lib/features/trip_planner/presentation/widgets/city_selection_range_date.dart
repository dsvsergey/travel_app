import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../domain/entities/city.dart';
import 'city_button_list.dart';
import 'custom_calendar_viewer.dart';

class CitySelectionRangeDate extends StatefulWidget {
  final List<City> cities;
  final Map<String, DateTimeRange?> selectedDates;
  final Function(City) onCitySelected;
  final Function(Map<String, DateTimeRange?>) onDateSelected;

  const CitySelectionRangeDate({
    super.key,
    required this.cities,
    required this.selectedDates,
    required this.onCitySelected,
    required this.onDateSelected,
  });

  @override
  State<CitySelectionRangeDate> createState() => _CitySelectionRangeDateState();
}

class _CitySelectionRangeDateState extends State<CitySelectionRangeDate> {
  City? _selectedCity;

  @override
  void initState() {
    super.initState();

    _selectedCity = widget.cities.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CityButtonList(
            cities: widget.cities,
            onCitySelected: (index, city) {
              setState(() {
                _selectedCity = city;
              });
              widget.onCitySelected(city);
            },
            onReorder: (value) {},
          ),
          const SizedBox(height: 16),
          CustomCalendarViewer(
            activeColor: _selectedCity?.color ?? Colors.blue,
            disableSwipe: true,
            calendarType: CustomCalendarType.multiRanges,
            onRangesUpdated: (ranges) {
              setState(() {});
              //widget.onDateSelected();
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {},
            child: Text(L10n.of(context).done),
          ),
        ],
      ),
    );
  }
}
