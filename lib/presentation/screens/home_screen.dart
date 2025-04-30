import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:vishare/data/models/vehicle_model.dart';
import 'package:vishare/data/repositories/vehicle_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapController _mapController;
  final double _initialZoom = 14;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleRepository>(context, listen: false).loadVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehicles = Provider.of<VehicleRepository>(context).vehicles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veicoli Disponibili'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          )
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(45.4642, 9.1900),
          zoom: _initialZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.vishare',
          ),
          MarkerLayer(
            markers: vehicles.map((vehicle) => Marker(
              point: LatLng(vehicle.lat, vehicle.lng),
              child: GestureDetector(
                onTap: () => _showBookingDialog(vehicle),
                child: Icon(
                  _getVehicleIcon(vehicle.type),
                  color: _getVehicleColor(vehicle.type),
                  size: 40,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQRCode,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Color _getVehicleColor(String type) {
    switch(type) {
      case 'bike': return Colors.green;
      case 'scooter': return Colors.blue;
      case 'car': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getVehicleIcon(String type) {
    switch(type) {
      case 'bike': return Icons.pedal_bike;
      case 'scooter': return Icons.electric_scooter;
      case 'car': return Icons.directions_car;
      default: return Icons.location_pin;
    }
  }

  void _scanQRCode() {
    // Implement QR scanner logic
  }

  void _showBookingDialog(Vehicle vehicle) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Prenota ${vehicle.type}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tariffa: ${vehicle.pricePerMinute.toStringAsFixed(2)}€/min'),
            const SizedBox(height: 8),
            Text('Batteria: ${vehicle.battery.toStringAsFixed(0)}%'),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('ANNULLA'),
            onPressed: () => Navigator.pop(ctx),
          ),
          TextButton(
            child: const Text('PRENOTA'),
            onPressed: () {
              Provider.of<VehicleRepository>(context, listen: false)
                .selectVehicle(vehicle);
              Navigator.pop(ctx);
              Navigator.pushNamed(context, '/booking');
            },
          ),
        ],
      ),
    );
  }
}
