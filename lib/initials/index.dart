import 'package:chapchapdeals_app/data/controller/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialsIndex extends StatefulWidget {
  const InitialsIndex({Key? key}) : super(key: key);

  @override
  State<InitialsIndex> createState() => _InitialsIndexState();
}

class _InitialsIndexState extends State<InitialsIndex> {
  
  final CountriesController _countriesController =
      Get.put(CountriesController());
  
  @override
  void initState() {
    super.initState();
    _countriesController.getPrefferedCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/IMG_2753.PNG'),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Chapchap',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              TextSpan(
                text: 'deals',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ])),
            const SizedBox(height: 20),
            Obx(() {
              if (_countriesController.isLoading.value) {
                return const CupertinoActivityIndicator();
              } else {
                _deciderForCountry();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text('Procceding'),
                    CupertinoActivityIndicator()
                  ],
                );
              }
            }),
          ]),
    );
  }

  void _deciderForCountry() {
    if (_countriesController.prefferedCountry.value == '') {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/initials/country', (_) => false);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      });
    }
  }
}
