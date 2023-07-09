import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class getcurrentlocation extends StatefulWidget {
  const getcurrentlocation({super.key});

  @override
  State<getcurrentlocation> createState() => _getcurrentlocationState();
}

class _getcurrentlocationState extends State<getcurrentlocation> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 14.4746);

  List<Marker> _marker = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: 'India Location Location')),
  ];
  // List<Marker> _List = [
  //   Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(20.5937, 78.9629),
  //       infoWindow: InfoWindow(title: 'India Location Location')),
  // ];

  loaddata() {
    getuserlocation().then((value) async {
      print(value.latitude.toString() + ' ' + value.longitude.toString());

      _marker.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(title: 'Current  Location')),
      );
      setState(() {});
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14.4746)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _marker.addAll(_List);
    loaddata();
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
        onPressed: () {
          getuserlocation().then((value) async {
            print(value.latitude.toString() + ' ' + value.longitude.toString());

            _marker.add(
              Marker(
                  markerId: MarkerId('2'),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(title: 'Current  Location')),
            );

            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(value.latitude, value.longitude),
                    zoom: 14.4746)));
          });
        },
      ),
    );
  }

  Future<Position> getuserlocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('Error ' + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }
}
