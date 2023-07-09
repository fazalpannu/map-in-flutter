import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class custummarker extends StatefulWidget {
  const custummarker({super.key});

  @override
  State<custummarker> createState() => _custummarkerState();
}

class _custummarkerState extends State<custummarker> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.692060, 74.021849), zoom: 14.4746);

  List<Marker> _marker = <Marker>[];

  List<String> images = [
    'images/flag.png',
    'images/marker.png',
    'images/sport-car.png',
    'images/user.png',
    'images/location-pin.png',
    'images/motorbike.png'
  ];

  final List<LatLng> _latng = <LatLng>[
    LatLng(31.693301, 74.023926),
    LatLng(31.692680, 74.022542),
    LatLng(31.693411, 74.022532),
    LatLng(31.692005, 74.024216),
    LatLng(31.693602, 74.023433),
    LatLng(31.693584, 74.021534),
  ];
  Uint8List? markerimage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LOADDATA();
  }

  LOADDATA() async {
    for (var i = 0; i < images.length; i++) {
      final Uint8List makericon = await getbytesfromasset(images[i], 100);
      _marker.add(Marker(
          icon: BitmapDescriptor.fromBytes(makericon),
          markerId: MarkerId(images[i].toString()),
          position: _latng[i],
          infoWindow: InfoWindow(title: ' Location' '$i')));
    }
  }

  Future<Uint8List> getbytesfromasset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
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
          myLocationButtonEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
        ),
      ),
    );
  }
}
