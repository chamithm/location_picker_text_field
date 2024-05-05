library open_street_location_picker;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'classes.dart';

// ignore: must_be_immutable
class LocationPicker extends StatefulWidget {
  String label;
  double? height;
  double? borderRadius;
  ValueChanged<OSMdata> onSelect;
  TextEditingController controller;

  LocationPicker({Key? key,required this.label,required this.controller,required this.onSelect,this.borderRadius,this.height}) : super(key: key);

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 50,
      child: TypeAheadField<OSMdata>(
        suggestionsCallback: (search) async{
          List<OSMdata> options = <OSMdata>[];
          var client = http.Client();
          try {
            String url = "https://nominatim.openstreetmap.org/search?q=$search&format=json&accept-language=en";
            var response = await client.get(Uri.parse(url));
            var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
            options = decodedResponse
                .map((e) => OSMdata(
                displayname: e['display_name'],
                latitude: double.parse(e['lat']),
                longitude: double.parse(e['lon'])))
                .toList();
          } on Exception {
            //print(e);
          } finally {
            client.close();
          }
          return options;
        },
        controller: widget.controller,
        builder: (context, controller, focusNode) {
          return TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.0),
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
                ),
                contentPadding: const EdgeInsets.only(left: 12, right: 12),
                labelText: widget.label,
                suffixIcon: IconButton(
                  onPressed: (){
                    widget.controller.clear();
                  },
                  icon: const Icon(Icons.cancel_outlined)
                ),
              )
          );
        },
        itemBuilder: (context, OSMdata suggestion) {
          return ListTile(
            leading: const Icon(Icons.my_location,size: 22,),
            title: Text(suggestion.displayname),
          );
        },
        onSelected: widget.onSelect,
      ),
    );
  }
}

