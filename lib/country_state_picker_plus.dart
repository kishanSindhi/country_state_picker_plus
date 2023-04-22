library country_state_picker_plus;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/status_model.dart';

class CountryStatePickerPlus extends StatefulWidget {
  final TextStyle? style;
  final Color? dropdownColor;
  final Widget? underline;
  final bool isExpanded;
  final BorderRadius? borderRadius;
  final bool autoFocus;
  final Widget? countryDisableHint;
  final Widget? stateDisableHint;
  final Widget? cityDisableHint;
  final int elevation;
  final bool? enableFeedback;
  final Color? focusColor;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final FocusNode? countryFocusNode;
  final FocusNode? stateFocusNode;
  final FocusNode? cityFocusNode;
  final String countryHintText;
  final String cityHintText;
  final String stateHintText;
  final Widget? icon;
  final double iconSize;
  final bool isDense;
  final double? itemHeight;
  final double? menuMaxHeight;
  final VoidCallback? onCountryTap;
  final VoidCallback? onStateTap;
  final VoidCallback? onCityTap;
  final Decoration? decoration;
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;

  const CountryStatePickerPlus({
    Key? key,
    this.style,
    this.countryFocusNode,
    this.elevation = 0,
    this.stateDisableHint,
    this.countryDisableHint,
    this.cityDisableHint,
    this.autoFocus = false,
    this.borderRadius,
    this.dropdownColor,
    this.underline,
    this.isExpanded = true,
    this.enableFeedback,
    this.focusColor,
    this.cityFocusNode,
    this.stateFocusNode,
    this.countryHintText = "Choose Country",
    this.stateHintText = "Choose State",
    this.cityHintText = "Choose City",
    this.icon,
    this.isDense = false,
    this.iconDisabledColor,
    this.iconSize = 24.0,
    this.iconEnabledColor,
    this.menuMaxHeight,
    this.itemHeight = kMinInteractiveDimension,
    this.onCityTap,
    this.onCountryTap,
    this.onStateTap,
    this.decoration,
    required this.onCountryChanged,
    required this.onStateChanged,
    required this.onCityChanged,
  }) : super(key: key);

  @override
  State<CountryStatePickerPlus> createState() => _CountryStatePickerPlusState();
}

class _CountryStatePickerPlusState extends State<CountryStatePickerPlus> {
  List<String> _cities = [];
  List<String> _country = [];
  String? _selectedCity;
  String? _selectedCountry;
  String? _selectedState;
  List<String> _states = <String>[];

  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle
        .loadString('packages/country_state_picker_plus/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    for (var data in countryres) {
      var model = StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) continue;
      setState(() {
        _country.add("${model.emoji!}    ${model.name!}");
      });
    }

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      if (!mounted) continue;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          _states.add(statename.toString());
        }
      });
    }

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.fromJson(map))
        .where((item) {
          return '${item.emoji}    ${item.name}' == _selectedCountry;
        })
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            _cities.add(citynames.toString());
          }
        });
      });
    }
    return _cities;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = null;
      _states = [];
      _selectedCity = null;
      _cities = [];
      _selectedCountry = value;
      getState();
    });
    widget.onCountryChanged(value);
    debugPrint(value);
    setState(() {});
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = null;
      _cities = [];
      _selectedState = value;
      getCity();
      widget.onStateChanged(value);
      debugPrint(value);
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      widget.onCityChanged(value);
    });
    debugPrint(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DecoratedBox(
          decoration: widget.decoration ?? const BoxDecoration(),
          child: DropdownButton<String>(
            isExpanded: widget.isExpanded,
            dropdownColor: widget.dropdownColor,
            borderRadius: widget.borderRadius,
            autofocus: widget.autoFocus,
            disabledHint: widget.countryDisableHint,
            elevation: widget.elevation,
            enableFeedback: widget.enableFeedback,
            focusColor: widget.focusColor,
            focusNode: widget.countryFocusNode,
            hint: Text(widget.countryHintText, style: widget.style),
            icon: widget.icon,
            iconDisabledColor: widget.iconDisabledColor,
            iconEnabledColor: widget.iconEnabledColor,
            iconSize: widget.iconSize,
            isDense: widget.isDense,
            itemHeight: widget.itemHeight,
            menuMaxHeight: widget.menuMaxHeight,
            onTap: widget.onCountryTap,
            style: widget.style,
            items: _country.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: widget.style,
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                _onSelectedCountry(value);
              }
            },
            value: _selectedCountry,
            underline: widget.underline,
          ),
        ),
        Visibility(
          visible: _states.isNotEmpty,
          child: DecoratedBox(
            decoration: widget.decoration ?? const BoxDecoration(),
            child: DropdownButton<String>(
              isExpanded: widget.isExpanded,
              dropdownColor: widget.dropdownColor,
              borderRadius: widget.borderRadius,
              autofocus: widget.autoFocus,
              disabledHint: widget.stateDisableHint,
              elevation: widget.elevation,
              enableFeedback: widget.enableFeedback,
              focusColor: widget.focusColor,
              focusNode: widget.stateFocusNode,
              hint: Text(widget.stateHintText, style: widget.style),
              icon: widget.icon,
              iconDisabledColor: widget.iconDisabledColor,
              iconEnabledColor: widget.iconEnabledColor,
              iconSize: widget.iconSize,
              isDense: widget.isDense,
              itemHeight: widget.itemHeight,
              menuMaxHeight: widget.menuMaxHeight,
              onTap: widget.onStateTap,
              style: widget.style,
              underline: widget.underline,
              items: _states.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem, style: widget.style),
                );
              }).toList(),
              onChanged: (value) => _onSelectedState(value!),
              value: _selectedState,
            ),
          ),
        ),
        Visibility(
          visible: _cities.isNotEmpty,
          child: DecoratedBox(
            decoration: widget.decoration ?? const BoxDecoration(),
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor,
              isExpanded: widget.isExpanded,
              borderRadius: widget.borderRadius,
              autofocus: widget.autoFocus,
              disabledHint: widget.cityDisableHint,
              elevation: widget.elevation,
              enableFeedback: widget.enableFeedback,
              focusColor: widget.focusColor,
              focusNode: widget.cityFocusNode,
              hint: Text(widget.cityHintText, style: widget.style),
              icon: widget.icon,
              iconDisabledColor: widget.iconDisabledColor,
              iconEnabledColor: widget.iconEnabledColor,
              iconSize: widget.iconSize,
              isDense: widget.isDense,
              itemHeight: widget.itemHeight,
              menuMaxHeight: widget.menuMaxHeight,
              onTap: widget.onCityTap,
              style: widget.style,
              items: _cities.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem, style: widget.style),
                );
              }).toList(),
              onChanged: (value) => _onSelectedCity(value!),
              value: _selectedCity,
            ),
          ),
        ),
      ],
    );
  }
}
