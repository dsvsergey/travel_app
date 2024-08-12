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
          top: 40,
          left: 20,
          right: 20,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: constraints.maxHeight * 0.5,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...state.cities.map((city) => CityCard(city: city)),
                      ...[
                        Row(
                          children: [
                            const Spacer(),
                            FloatingActionButton(
                              backgroundColor: Colors.amber,
                              onPressed: () {
                                context
                                    .read<CitySelectionBloc>()
                                    .add(AddSelectedCity());
                              },
                              child: const Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
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

  const CityCard({super.key, required this.city});

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
          onPressed: () {
            context.read<CitySelectionBloc>().add(RemoveSelectedCity(city.id));
          },
        ),
      ),
    );
  }
}
