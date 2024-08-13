import 'package:flutter/material.dart';

import '../../domain/entities/city.dart';

class CityButtonList extends StatefulWidget {
  final List<City> cities;
  final Function(int, City) onCitySelected;

  const CityButtonList({
    super.key,
    required this.cities,
    required this.onCitySelected,
  });

  @override
  State<CityButtonList> createState() => _CityButtonListState();
}

class _CityButtonListState extends State<CityButtonList> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(widget.cities.length, (index) {
        final city = widget.cities[index];
        final isSelected = _selectedIndex == index;

        return isSelected
            ? FilledButton(
                onPressed: () => _onPressed(index),
                style: FilledButton.styleFrom(
                  backgroundColor: city.color,
                ),
                child: Text(city.name),
              )
            : OutlinedButton(
                onPressed: () => _onPressed(index),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: city.color),
                ),
                child: Text(city.name),
              );
      }),
    );
  }

  void _onPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onCitySelected(index, widget.cities[index]);
  }
}
