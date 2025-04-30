import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle_model.dart';

/*class VehicleRepository extends ChangeNotifier {
  List<Vehicle> _vehicles = [];
  Vehicle? _selectedVehicle;

  List<Vehicle> get vehicles => _vehicles;
  Vehicle? get selectedVehicle => _selectedVehicle;


  Future<void> loadVehicles() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('status', isEqualTo: 'available')
        .get();

    _vehicles = snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
    notifyListeners();
  }

  void selectVehicle(Vehicle vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }
}*/


class VehicleRepository extends ChangeNotifier {
  Vehicle? _selectedVehicle;
  List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => _vehicles;
  Vehicle? get selectedVehicle => _selectedVehicle;

  Future<void> loadVehicles() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('vehicles')
        .where('status', isEqualTo: 'available')
        .get();

    _vehicles = snapshot.docs.map((doc) {
      final data = doc.data()!;
      return Vehicle(
        id: doc.id,
        type: data['type'] ?? 'unknown',
        pricePerMinute: (data['pricePerMinute'] as num?)?.toDouble() ?? 0.0,
        battery: (data['battery'] as num?)?.toDouble() ?? 0.0,
        lat: (data['location'] as GeoPoint).latitude,
        lng: (data['location'] as GeoPoint).longitude,
      );
    }).toList();
    
    notifyListeners();
  }

  void selectVehicle(Vehicle vehicle) {
    _selectedVehicle = vehicle;
    notifyListeners();
  }
}