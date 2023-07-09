import 'package:ch12/model/conver_latitude_address.dart';
import 'package:ch12/model/custum_info.dart';
import 'package:ch12/model/custum_marker.dart';
import 'package:ch12/model/maptheme.dart';
import 'package:ch12/model/network_marker.dart';
import 'package:ch12/model/places_api.dart';
import 'package:ch12/model/polygon.dart';
import 'package:ch12/model/polyline.dart';
import 'package:ch12/model/usergetcurrentlocation.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: ConvertLAtitudetoAddress(),
    );
  }
}
