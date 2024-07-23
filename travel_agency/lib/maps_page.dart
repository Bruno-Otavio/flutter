import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final LatLng _pGooglePlex =
      const LatLng(-22.742401262742213, -46.8982561742067);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 10),
        markers: {
          Marker(
            markerId: const MarkerId('_currentLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGooglePlex
          ),
          Marker(
            markerId: const MarkerId('_sourceLocation'),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGooglePlex
          ),
        },
      ),
    );
  }
  
  Future<void> getLocationUpdates() async {
    bool _serviceEnable;
    
  }
}