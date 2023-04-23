## country_state_picker_plus

```country_state_picker_plus``` is a Flutter package that provides a customizable picker widget for selecting a country, state, and city from a dropdown list. It is designed to make it easy for developers to integrate a picker widget for selecting countries, states, and cities into their Flutter projects.

With ```country_state_picker_plus```, you can customize the appearance of the picker widget by setting properties of DropdownButton and InputDecoration. Additionally, the package supports multiple languages and locales, making it easy to create a picker widget that can be used in various countries and regions around the world.

## Features

* Select a country, state, and city from a dropdown list.
* Customize the appearance of the picker widget with properties of ```DropdownButton``` and ```InputDecoration```.
* Provides an ```onChanged``` callback that is triggered when the user selects a value from the picker widget.
* Lightweight and easy to use, with minimal setup required to integrate into a Flutter project.

## Example

```dart
CountryStatePickerPlus(
  onCityChanged: (value) {
    result += ' $value';
  },
  onCountryChanged: (value) {
    result = value;
  },
  onStateChanged: (value) {
    result += ' $value';
  },
);
```

![Screenshot](https://github.com/kishanSindhi/country_state_picker_plus/blob/main/screenshots/country_state_picker_plus.gif?raw=true)

## Special Thanks

* countries-states-cities-database
