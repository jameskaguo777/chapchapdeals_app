import 'package:chapchapdeals_app/data/model/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/controller/countries.dart';

class InitializeCountry extends StatefulWidget {
  const InitializeCountry({Key? key}) : super(key: key);

  @override
  State<InitializeCountry> createState() => _InitializeCountryState();
}

class _InitializeCountryState extends State<InitializeCountry> {
  final CountriesController _countriesController = Get.find();

  late String dropdownValue = 'TZ';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text('Choose your Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (_countriesController.isLoading.value) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return Image.network(_countriesController.countryFlagImage.value);
              }
            }),
            const SizedBox(height: 20),
            Obx(() {
              if (_countriesController.isLoading.value) {
                return const Center(
                    child: CupertinoActivityIndicator(
                  color: Colors.white,
                ));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _countryWidget(_countriesController.countries),
                );
              }
            }),
            const SizedBox(height: 20),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
                shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        )),
              ),
              onPressed: () {
                _countriesController.setPrefferedCountry(dropdownValue);

                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              child: Obx((){
                if (_countriesController.isLoading.value) {
                  return const Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.green,
                  ));
                } else {
                  return Text(
                    'Continue',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.green),
                  );
                }
              
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countryWidget(List<CountriesModel> countriesList) => SizedBox(
        width: double.infinity,
        height: 60,
        child: DropdownButtonFormField(
            focusColor: Colors.white,
            iconDisabledColor: Colors.blueGrey,
            iconEnabledColor: Colors.white,
            dropdownColor: Colors.black,
            decoration: InputDecoration(
                iconColor: Colors.green,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white, width: 4),
                ),
                prefixIcon: const Icon(
                  Icons.location_on,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 4),
                ),
                hintText: 'Select Location',
                hintStyle: Theme.of(context).textTheme.caption,
                focusColor: Colors.white),
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(
              Icons.arrow_downward_rounded,
            ),
            isExpanded: true,
            value: dropdownValue,
            items: countriesList
                .map((e) => DropdownMenuItem(
                    value: e.code,
                    child: Text(
                      e.name!,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )))
                .toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                _countriesController.getImageFlagCountry(dropdownValue);
              });
            }),
      );
}
