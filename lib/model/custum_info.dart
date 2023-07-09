import 'dart:typed_data';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class custuminfo extends StatefulWidget {
  const custuminfo({super.key});

  @override
  State<custuminfo> createState() => _custuminfoState();
}

class _custuminfoState extends State<custuminfo> {
  Uint8List? markerimage;
  CustomInfoWindowController _controller = CustomInfoWindowController();
  List<Marker> _marker = <Marker>[];
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.692060, 74.021849), zoom: 14.4746);
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

  LOADDATA() async {
    for (var i = 0; i < _latng.length; i++) {
      final Uint8List makericon = await getbytesfromasset(images[i], 100);
      _marker.add(Marker(
        icon: BitmapDescriptor.fromBytes(makericon),
        markerId: MarkerId(_latng[i].toString()),
        position: _latng[i],
        onTap: () {
          _controller.addInfoWindow!(
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.cyan,
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/16677735/pexels-photo-16677735/free-photo-of-pizza-with-dry-curled-ham-and-rucola-on-a-wooden-table.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.red,
                      ),
                    ),
                    ListTile(
                      textColor: Colors.white,
                      title: Text('Tasty Pizza'),
                      subtitle: Text('very delicious !!!!!!!!!!!!!!!1'),
                    ),
                  ],
                ),
              ),
              _latng[i]);
        },
        // infoWindow: InfoWindow(title: ' Location' '$i')
      ));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    LOADDATA();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.googleMapController = controller;
            },
            onTap: (argument) {
              _controller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _controller.onCameraMove!();
            },
            markers: Set<Marker>.of(_marker),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            mapType: MapType.normal,
          ),
          CustomInfoWindow(
            controller: _controller,
            height: 200,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}
