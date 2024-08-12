import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/trip_planner/presentation/block/city_selection_bloc.dart';
import 'features/trip_planner/presentation/pages/city_selection_page.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CitySelectionBloc>(
          create: (context) => getIt<CitySelectionBloc>()..add(LoadCities()),
        )
      ],
      child: MaterialApp(
        title: 'MapBox Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('uk', ''),
        ],
        debugShowCheckedModeBanner: false,
        home: const CitySelectionPage(),
      ),
    );
  }
}
