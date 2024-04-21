// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(LocationFinderApp());

class LocationFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Finder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: LocationFinderPage(),
    );
  }
}

class LocationFinderPage extends StatefulWidget {
  @override
  _LocationFinderPageState createState() => _LocationFinderPageState();
}

class _LocationFinderPageState extends State<LocationFinderPage> {
  final TextEditingController _locationController = TextEditingController();
  String _coordinates = '';

  void _fetchCoordinates() async {
    final String location = _locationController.text;
    final String apiKey = '8884acd426cc4b89bff6b0297a0b295b';
    final String url =
        'https://api.opencagedata.com/geocode/v1/json?q=$location&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final double latitude = data['results'][0]['geometry']['lat'];
      final double longitude = data['results'][0]['geometry']['lng'];
      setState(() {
        _coordinates = 'Latitude: $latitude, Longitude: $longitude';
      });
    } else {
      setState(() {
        _coordinates = 'Failed to fetch coordinates';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter Location',
                labelStyle: TextStyle(color: Colors.indigoAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchCoordinates,
              child: Text('Find Coordinates'),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigoAccent,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              _coordinates,
              style: TextStyle(fontSize: 24, color: Colors.indigoAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// pubspec.yaml
// dependencies:
//  flutter:
//     sdk: flutter
//  http: ^0.13.3 # For making HTTP requests


