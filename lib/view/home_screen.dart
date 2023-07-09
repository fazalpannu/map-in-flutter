import 'dart:async';
import 'dart:core';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.693381, 74.023508), zoom: 14.4746);

  List<Marker> _marker = [];
  List<Marker> _List = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.691889, 74.022418),
        infoWindow: InfoWindow(title: 'Janat Town')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(31.693381, 74.023508),
        infoWindow: InfoWindow(title: 'My Current Location')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: 'India Location Location')),
  ];
  Future<void> checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isGranted) {
      // Location permission already granted
      // Proceed with your logic
    } else {
      // Location permission not granted
      // Request location permission
      requestLocationPermission();
    }
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      // Location permission granted
      // Proceed with your logic
    } else {
      // Location permission denied
      // Display a message or handle the denied permission case
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_List);
    checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(_marker),
          myLocationEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 14.4746)));
        },
      ),
    );
  }
}
