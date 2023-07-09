import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class networkmarker extends StatefulWidget {
  const networkmarker({super.key});

  @override
  State<networkmarker> createState() => _networkmarkerState();
}

class _networkmarkerState extends State<networkmarker> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.696799, 74.036782), zoom: 14.4746);

  final List<LatLng> _latng = <LatLng>[
    LatLng(31.696799, 74.036782), //first and last points has same latitude
    LatLng(31.706377, 73.975700),
    // LatLng(31.729705, 74.009779),
    LatLng(31.679560, 74.012587),
    LatLng(31.688157, 74.029683),
  ];

  final Set<Marker> _marker = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  loaddata() async {
    Uint8List? image = await loadimage(
        'https://cdn-icons-png.flaticon.com/128/4139/4139981.png');
    final ui.Codec markercodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100);
    final ui.FrameInfo frameInfo = await markercodec.getNextFrame();
    final ByteData? byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizemarker = byteData!.buffer.asUint8List();

    for (var i = 0; i < _latng.length; i++) {
      _marker.add(Marker(
        icon: BitmapDescriptor.fromBytes(resizemarker),
        markerId: MarkerId('$i'),
        position: _latng[i],
        infoWindow:
            InfoWindow(title: ' Location' '$i', snippet: '5 Star Rating'),
      ));
      // setState(() {});
    }
  }

  Future<Uint8List?> loadimage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    final imageinfo = await completer.future;
    final bytedata =
        await imageinfo.image.toByteData(format: ui.ImageByteFormat.png);
    return bytedata?.buffer.asUint8List();
  }

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
      ),
    );
  }
}
