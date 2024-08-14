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
  int? _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(widget.cities.length, (index) {
        final city = widget.cities[index];
        final isSelected = _selectedIndex == index;
        final textColor = _getTextColor(city.color);

        return isSelected
            ? FilledButton(
                onPressed: () => _onPressed(index),
                style: FilledButton.styleFrom(
                  backgroundColor: city.color,
                ),
                child: Text(
                  city.name,
                  style: TextStyle(color: textColor),
                ),
              )
            : OutlinedButton(
                onPressed: () => _onPressed(index),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: city.color),
                  foregroundColor: city.color,
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

  Color _getTextColor(Color backgroundColor) {
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
