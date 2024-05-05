<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Location Picker Text Field

A Location Picker Text Field (autocomplete) widget for Flutter, where you can show any location suggestions to users as they type.  
  

<img src="https://raw.githubusercontent.com/chamithm/Intro/main/assets/sc1.png" alt="Success Status" width="200" height="360">
<img src="https://raw.githubusercontent.com/chamithm/Intro/main/assets/sc2.png" alt="Success Status" width="200" height="360">

## Features
- Shows suggestions in an floating box with the same width as your TextField.  
- Allows to get the Latitude and Longitude of selected location.

## Usage
You can import the package with:
```dart
  import 'package:location_picker_text_field/open_street_location_picker.dart';
```
Use this code for easy development
```dart
  TextEditingController locationName = TextEditingController();
  Container(
    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    child: LocationPicker(
      label: "From",
      controller: locationName,
      onSelect: (data){
        locationName.text = data.displayname;
      },
    ),
  )
```

