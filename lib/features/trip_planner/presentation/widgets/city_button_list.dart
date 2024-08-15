import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

import '../../domain/entities/city.dart';
import '../block/city_selection_bloc.dart';

class CityButtonList extends StatefulWidget {
  final List<City> cities;
  final Function(int, City) onCitySelected;
  final Function(List<City>) onReorder;

  const CityButtonList({
    super.key,
    required this.cities,
    required this.onCitySelected,
    required this.onReorder,
  });

  @override
  State<CityButtonList> createState() => _CityButtonListState();
}

class _CityButtonListState extends State<CityButtonList> {
  late List<City> _cities;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _cities = List.from(widget.cities)
      ..sort((a, b) => (a.index ?? 0).compareTo(b.index ?? 0));
    _selectedIndex = _cities.isNotEmpty ? _cities[0].index : null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ReorderableWrap(
        controller: ScrollController(),
        needsLongPressDraggable: true,
        spacing: 8.0,
        runSpacing: 8.0,
        padding: const EdgeInsets.all(8),
        children: _cities.map((city) {
          return CityButton(
            key: ValueKey(city.id),
            city: city,
            isSelected: _selectedIndex == city.index,
            textColor: _getTextColor(city.color),
            onPressed: () => _onPressed(_cities.indexOf(city)),
          );
        }).toList(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            final City city = _cities.removeAt(oldIndex);
            _cities.insert(newIndex, city);
            for (int i = 0; i < _cities.length; i++) {
              _cities[i] = _cities[i].copyWith(index: i);
            }
          });
          widget.onReorder(_cities);
          context.read<CitySelectionBloc>().add(
                ReorderCitiesEvent(oldIndex: oldIndex, newIndex: newIndex),
              );
        },
        onNoReorder: (int index) {
          debugPrint('${_cities[index].name} was not reordered');
        },
        onReorderStarted: (int index) {
          debugPrint('Started reordering ${_cities[index].name}');
        },
        buildDraggableFeedback: (context, constraints, child) {
          return Material(
            elevation: 6.0,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: ConstrainedBox(
              constraints: constraints,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Opacity(
                  opacity: 0.7,
                  child: child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPressed(int index) {
    setState(() {
      _selectedIndex = _cities[index].index;
    });
    widget.onCitySelected(index, _cities[index]);
  }

  Color _getTextColor(Color backgroundColor) {
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class CityButton extends StatelessWidget {
  final City city;
  final bool isSelected;
  final Color textColor;
  final VoidCallback onPressed;

  const CityButton({
    super.key,
    required this.city,
    required this.isSelected,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: city.color,
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              city.name,
              style: TextStyle(color: textColor),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: city.color),
              foregroundColor: city.color,
              minimumSize: const Size(100, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(city.name),
          );
  }
}
