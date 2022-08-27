import 'package:chapchapdeals_app/home/index.dart';
import 'package:chapchapdeals_app/post/index.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'initials/index.dart';
import 'initials/initial_country.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.black,
          surface: Colors.white,
          background: Color.fromARGB(255, 238, 238, 238),
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
        '/post': (context) => const PostView(),
      },
    );
  }
}