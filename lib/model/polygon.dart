import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class polygon extends StatefulWidget {
  const polygon({super.key});

  @override
  State<polygon> createState() => _polygonState();
}

class _polygonState extends State<polygon> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.696799, 74.036782), zoom: 14.4746);

  final List<LatLng> points = <LatLng>[
    LatLng(31.696799, 74.036782), //first and last points has same latitude
    LatLng(31.706377, 73.975700),
    // LatLng(31.729705, 74.009779),
    LatLng(31.679560, 74.012587),
    LatLng(31.688157, 74.029683),
    LatLng(31.696799, 74.036782),
  ];

  Set<Polygon> _polygon = HashSet<Polygon>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
        polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.pink.withOpacity(0.4),
        strokeWidth: 4,
        geodesic: true,
        strokeColor: Colors.black12));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polygons: _polygon,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
