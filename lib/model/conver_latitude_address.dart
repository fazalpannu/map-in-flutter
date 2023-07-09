import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLAtitudetoAddress extends StatefulWidget {
  const ConvertLAtitudetoAddress({super.key});

  @override
  State<ConvertLAtitudetoAddress> createState() =>
      _ConvertLAtitudetoAddressState();
}

class _ConvertLAtitudetoAddressState extends State<ConvertLAtitudetoAddress> {
  String str1 = '', str2 = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' Google Map '), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str1),
          Text(str2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                List<Location> locations =
                    await locationFromAddress("bhatti chowk sheikhupura");
                str1 = locations.last.latitude.toString() +
                    '   ' +
                    locations.last.longitude.toString();
                print(str1);

                List<Placemark> placemarks = await placemarkFromCoordinates(
                    locations.last.latitude, locations.last.longitude);

                str2 = placemarks.reversed.last.country.toString() +
                    '   ' +
                    placemarks.reversed.last.subLocality.toString();

                setState(() {});
              },
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.brown),
                  child: Center(
                    child: Text(
                      'Lattitude \n Convert Address',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
