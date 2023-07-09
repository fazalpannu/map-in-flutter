import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class placesapi extends StatefulWidget {
  const placesapi({super.key});

  @override
  State<placesapi> createState() => _placesapiState();
}

class _placesapiState extends State<placesapi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String sessionToken = '122344';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.addListener(() {
      onchange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places Api'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search places with name',
            ),
          )
        ],
      ),
    );
  }

  void onchange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
      getsuggestion(_controller.text);
    }
  }

  void getsuggestion(String text) async {
    String Kplace_api_key = 'AIzaSyDL8h4BD7XnALHpZxiCPXiArVJpyj3PrYg';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$text&key=$Kplace_api_key&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Error');
    }
  }
}
