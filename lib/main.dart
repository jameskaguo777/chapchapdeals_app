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
      ),
      initialRoute: '/initials',
      routes: {
        '/initials': (context) => const InitialsIndex(),
        '/initials/country': (context) => const InitializeCountry(),
        '/' :(context) => const HomeIndex(),
      },
    );
  }
}