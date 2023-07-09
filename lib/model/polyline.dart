import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class polyline extends StatefulWidget {
  const polyline({super.key});

  @override
  State<polyline> createState() => _polylineState();
}

class _polylineState extends State<polyline> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.696799, 74.036782), zoom: 14.4746);

  final List<LatLng> _latng = <LatLng>[
    LatLng(31.696799, 74.036782),
    LatLng(31.706377, 73.975700),
    // LatLng(31.729705, 74.009779),
    LatLng(31.679560, 74.012587),
    LatLng(31.688157, 74.029683),
  ];

  final Set<Marker> _marker = {};
  final Set<Polyline> _poline = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < _latng.length; i++) {
      _marker.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId('$i'),
        position: _latng[i],
        infoWindow:
            InfoWindow(title: ' Location' '$i', snippet: '5 Star Rating'),
      ));
      // setState(() {});
    }

    _poline.add(Polyline(
        polylineId: PolylineId('1'),
        points: _latng,
        color: Colors.cyan,
        startCap: Cap.squareCap,
        endCap: Cap.squareCap));
  }

  // ignore: unused_element
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
        polylines: _poline,
      ),
    );
  }
}
