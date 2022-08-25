import 'package:chapchapdeals_app/home/index.dart';
import 'package:flutter/material.dart';

import 'initials/index.dart';
import 'initials/initial_country.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chapchapdeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.black,
          surface: Colors.white,
          background: Colors.grey,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialsIndex(),
        '/initials/country': (context) => const InitializeCountry(),
        '/home' :(context) => const HomeIndex(),
      },
    );
  }
}