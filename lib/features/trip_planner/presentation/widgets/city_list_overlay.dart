import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/city.dart';
import '../block/city_selection_bloc.dart';

class CityListOverlay extends StatelessWidget {
  const CityListOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitySelectionBloc, CitySelectionState>(
      builder: (context, state) {
        return Positioned(
          top: 55,
          left: 20,
          right: 20,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: constraints.maxHeight * 0.5,
                ),
                child: ReorderableListView(
                  key: ValueKey(state.cities.length),
                  shrinkWrap: true,
                  children: [
                    ...state.cities.asMap().entries.map((entry) {
                      final city = entry.value;
                      return CityCard(
                        key: ValueKey(city.id),
                        city: city,
                        onRemove: () {
                          context
                              .read<CitySelectionBloc>()
                              .add(RemoveSelectedCity(city.id));
                        },
                      );
                    }),
                    ListTile(
                      key: const ValueKey('add_button'),
                      trailing: FloatingActionButton(
                        backgroundColor: Colors.amber,
                        onPressed: () {
                          context
                              .read<CitySelectionBloc>()
                              .add(AddSelectedCity());
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    context.read<CitySelectionBloc>().add(
                          ReorderCitiesEvent(
                              oldIndex: oldIndex, newIndex: newIndex),
                        );
                  },
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget? child) {
                        final double animValue =
                            Curves.easeInOut.transform(animation.value);
                        final double elevation = lerpDouble(0, 6, animValue)!;
                        return Material(
                          elevation: elevation,
                          color: Colors.transparent,
                          shadowColor: Colors.black.withOpacity(0.3),
                          child: child,
                        );
                      },
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CityCard extends StatelessWidget {
  final City city;
  final VoidCallback onRemove;

  const CityCard({
    super.key,
    required this.city,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(city.name),
        subtitle: Text('${city.country} (${city.countryCode})'),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
