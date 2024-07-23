import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/directions_model.dart';
import 'package:google_maps/directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController _mapController;

  Marker? _originMarker;
  Marker? _destinationMarker;

  Directions? _info;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _originController = TextEditingController();
  final _destinationController = TextEditingController();

  String? _origin;
  String? _destination;
  LatLng? _currentLocation;

  final LatLng _pPedreira =
      const LatLng(-22.742401262742213, -46.8982561742067);

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
    _originController.dispose();
    _destinationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            onChanged: () {},
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _originController,
                    decoration: const InputDecoration(
                      hintText: 'Origem',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favr, insira uma Origem';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _destinationController,
                    decoration: const InputDecoration(
                      hintText: 'Destino',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favr, insira um Destino';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _origin = _originController.text;
                      _destination = _destinationController.text;
                      _addMarker();
                    }
                  },
                  child: const Text('Procurar'),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              _currentLocation = await _determinePosition();
              _originController.text = 'Localização atual';
            },
            child: const Text('Usar Localização Atual como Origem'),
          ),
          _info != null
              ? Text('Distância total: ${_info!.totalDistance}')
              : const Text(''),
          FutureBuilder(
              future: _determinePosition(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final location = <String, dynamic>{
                    'lat': snapshot.data!.latitude,
                    'lng': snapshot.data!.longitude,
                  };
                  return Text('${location['lat']} ${location['lng']}');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return const Center(child: CircularProgressIndicator());
              }),
          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _pPedreira, zoom: 10),
              onMapCreated: (controller) => _mapController = controller,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: {
                if (_originMarker != null) _originMarker!,
                if (_destinationMarker != null) _destinationMarker!,
              },
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red.shade300,
                    width: 5,
                    points: _info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _mapController.animateCamera(_info != null
            ? CameraUpdate.newLatLngBounds(_info!.bounds, 75.0)
            : CameraUpdate.newCameraPosition(
                CameraPosition(target: _pPedreira, zoom: 10))),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker() async {
    late LatLng originLocation;

    if (_currentLocation != null) {
      originLocation = _currentLocation!;
    } else {
      originLocation = await DirectionsRepository.getLatLng(_origin!);
    }

    final LatLng destinationLocation =
        await DirectionsRepository.getLatLng(_destination!);

    final destination = await DirectionsRepository.getDirections(
        origin: originLocation, destination: destinationLocation);

    setState(() {
      _originMarker = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarker,
          position: originLocation);

      _destinationMarker = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: destinationLocation);

      _info = destination;
    });
  }

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final location = await Geolocator.getCurrentPosition();

    return LatLng(location.latitude, location.longitude);
  }
}
