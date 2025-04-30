import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String type;
  final double lat;
  final double lng;
  final double battery;
  final double pricePerMinute;

  Vehicle({
    required this.id,
    required this.type,
    required this.lat,
    required this.lng,
    required this.battery,
    required this.pricePerMinute,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final GeoPoint geoPoint = data['location'];
    
    return Vehicle(
      id: doc.id,
      type: data['type'] ?? 'sconosciuto',
      lat: geoPoint.latitude,
      lng: geoPoint.longitude,
      battery: (data['battery'] as num?)?.toDouble() ?? 0.0,
      pricePerMinute: (data['pricePerMinute'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
