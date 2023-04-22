import 'package:flutter/material.dart';
import 'package:country_state_picker_plus/country_state_picker_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CountryStatePickerPlus(
                  onCityChanged: (value) {
                    result += ' $value';
                    setState(() {});
                  },
                  onCountryChanged: (value) {
                    result = value;
                    setState(() {});
                  },
                  onStateChanged: (value) {
                    result += ' $value';
                    setState(() {});
                  },
                ),
              ),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }
}
