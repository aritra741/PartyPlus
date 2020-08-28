import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  List<Marker>locations= <Marker>[];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      locations.add(
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(24.887635,91.874310),
              infoWindow: InfoWindow(
                  title: 'International Convention City'
              )
          )
      );
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MapView'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(24.887635,91.874310),
            zoom: 9.0,
          ),
          mapType: MapType.normal,
          markers: Set<Marker>.of(locations),
          onMapCreated: _onMapCreated
        ),
      ),
    );
  }
}
