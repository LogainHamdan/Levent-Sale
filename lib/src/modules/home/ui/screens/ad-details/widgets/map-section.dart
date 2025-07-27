import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatelessWidget {
  final String? latitude;
  final String? longitude;

  const MapSection({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    double? parsedLat;
    double? parsedLng;

    try {
      parsedLat = latitude != null ? double.tryParse(latitude!) : null;
      parsedLng = longitude != null ? double.tryParse(longitude!) : null;
    } catch (e) {
      debugPrint('Error parsing coordinates: $e');
    }

    if (parsedLat == null || parsedLng == null) {
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: Center(
          child: Text(
            latitude == null || longitude == null
                ? 'Location not available'
                : 'Invalid coordinates',
          ),
        ),
      );
    }

    final location = LatLng(parsedLat, parsedLng);

    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: location,
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: location,
                width: 40,
                height: 40,
                child:
                    const Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
          const RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
