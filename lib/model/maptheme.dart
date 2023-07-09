import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class styletheme extends StatefulWidget {
  const styletheme({super.key});

  @override
  State<styletheme> createState() => _stylethemeState();
}

class _stylethemeState extends State<styletheme> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(31.696799, 74.036782), zoom: 14.4746);
  String maptheme = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/night_theme.json')
        .then((string) {
      maptheme = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Style'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/silver.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: Text('Silver')),
                    PopupMenuItem(
                        onTap: () {
                          _controller.future.then((value) {
                            DefaultAssetBundle.of(context)
                                .loadString('assets/maptheme/night_theme.json')
                                .then((string) {
                              value.setMapStyle(string);
                            });
                          });
                        },
                        child: Text('Night'))
                  ])
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(maptheme);
            _controller.complete(controller);
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          // mapType: MapType.normal,//its remove
        ),
      ),
    );
  }
}
