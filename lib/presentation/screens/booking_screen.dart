/*import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:vishare/data/repositories/vehicle_repository.dart';

import 'package:flutter/foundation.dart'; 
import 'dart:io' show Platform;


class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = 'pk_test_...';
    Stripe.merchantIdentifier = 'merchant.com.vishare';
  }

  Future<void> _handlePayment() async {
    try {
      final paymentIntent = await _createPaymentIntent();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'ViShare',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pagamento riuscito!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore: ${e.toString()}')),
      );
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent() async {
    // Implementa la chiamata al tuo backend
    return {'client_secret': '...'};
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = Provider.of<VehicleRepository>(context).selectedVehicle;
    if (vehicle == null) return const Scaffold(body: Center(child: Text('Nessun veicolo selezionato')));

    return Scaffold(
      appBar: AppBar(title: const Text('Prenota Veicolo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(vehicle.type.toUpperCase()),
              subtitle: Text('${vehicle.pricePerMinute.toStringAsFixed(2)}€/min'),
            ),
            ElevatedButton(
              onPressed: _handlePayment,
              child: const Text('Paga con Carta'),
            ),
          ],
        ),
      ),
    );
  }


  void _scanQRCode() async {
    if(kIsWeb) {
      // Web-specific QR scanning
      final qrCode = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Inserisci codice QR'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Codice QR'),
            onSubmitted: (value) => Navigator.pop(ctx, value),
          ),
        ),
      );
      if(qrCode != null) _processQR(qrCode);
    } else {
      // Mobile QR scanning
      final qrResult = await Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => QRView()),
      );
      if(qrResult != null) _processQR(qrResult);
    }
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:vishare/data/repositories/vehicle_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = 'pk_test_YOUR_STRIPE_KEY_HERE'; // Replace with your key
    Stripe.merchantIdentifier = 'merchant.com.vishare';
  }

  Future<void> _handlePayment() async {
    try {
      final paymentIntent = await _createPaymentIntent();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'ViShare',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pagamento riuscito!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore: ${e.toString()}')),
      );
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent() async {
    // Implement backend call
    return {'client_secret': '...'};
  }

  void _processQR(String qrCode) {
    if (qrCode.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR valido: $qrCode')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = Provider.of<VehicleRepository>(context).selectedVehicle;
    if (vehicle == null) return const Scaffold(body: Center(child: Text('Nessun veicolo selezionato')));

    return Scaffold(
      appBar: AppBar(title: const Text('Prenota Veicolo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(vehicle.type.toUpperCase()),
              subtitle: Text('${vehicle.pricePerMinute.toStringAsFixed(2)}€/min'),
            ),
            ElevatedButton(
              onPressed: _handlePayment,
              child: const Text('Paga con Carta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQRCode,
              child: const Text('Scansiona QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  void _scanQRCode() async {
    if (kIsWeb) {
      final qrCode = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Inserisci codice QR'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'Codice QR'),
            onSubmitted: (value) => Navigator.pop(ctx, value),
          ),
        ),
      );
      if (qrCode != null) _processQR(qrCode);
    } else {
      final qrResult = await Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => QRView(
          key: const Key('qr_view'), // Fixed key parameter
          onQRViewCreated: (controller) {
            controller.scannedDataStream.listen((scanData) {
              Navigator.pop(ctx, scanData.code);
            });
          },
        )),
      );
      if (qrResult != null) _processQR(qrResult);
    }
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishare/data/repositories/vehicle_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  void _confirmMockPayment() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pagamento'),
        content: const Text('Pagamento avvenuto con successo!'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  /*void _processQR(String qrCode) async {
    final vehicle = Provider.of<VehicleRepository>(context, listen: false).selectedVehicle;
    final user = FirebaseAuth.instance.currentUser; // Add Firebase Auth first
    
    if (vehicle == null || user == null) return;

    // 1. Verify QR matches vehicle ID
    if (qrCode != vehicle.id) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code non valido!'))
      );
      return;
    }

    // 2. Update vehicle status
    await FirebaseFirestore.instance
      .collection('vehicles')
      .doc(vehicle.id)
      .update({'status': 'in-use'});

    // 3. Create booking
    final bookingRef = await FirebaseFirestore.instance
      .collection('bookings')
      .add({
        'userId': user.uid,
        'vehicleId': vehicle.id,
        'startTime': Timestamp.now(),
        'cost': vehicle.pricePerMinute * 30 // 30 min demo
      });

    // 4. Add to user's bookings
    await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .update({
        'bookings': FieldValue.arrayUnion([bookingRef.id])
      });

    // 5. Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prenotazione confermata!'))
    );


/*
    if (qrCode.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code scansionato con successo!')),
      );
    }
*/
  }*/


  void _processQR(String qrCode) async {
    if (!mounted) return;
    final vehicle = Provider.of<VehicleRepository>(context, listen: false).selectedVehicle;
    final user = FirebaseAuth.instance.currentUser;
    
    if (vehicle == null || user == null) return;

    if (qrCode != vehicle.id) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code non valido!'))
      );
      return;
    }

    await FirebaseFirestore.instance
      .collection('vehicles')
      .doc(vehicle.id)
      .update({'status': 'in-use'});

    final bookingRef = await FirebaseFirestore.instance
      .collection('bookings')
      .add({
        'userId': user.uid,
        'vehicleId': vehicle.id,
        'startTime': Timestamp.now(),
        'cost': vehicle.pricePerMinute * 30
      });

    await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .update({
        'bookings': FieldValue.arrayUnion([bookingRef.id])
      });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prenotazione confermata!'))
    );
  }


  @override
  Widget build(BuildContext context) {
    final vehicle = Provider.of<VehicleRepository>(context).selectedVehicle;
    if (vehicle == null) return const Scaffold(body: Center(child: Text('Nessun veicolo selezionato')));

    return Scaffold(
      appBar: AppBar(title: const Text('Prenota Veicolo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(vehicle.type.toUpperCase()),
              subtitle: Text('${vehicle.pricePerMinute.toStringAsFixed(2)}€/min'),
            ),
            ElevatedButton(
              onPressed: _confirmMockPayment,
              child: const Text('Pagamento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanQRCode,
              child: const Text('Scansione QR'),
            ),
          ],
        ),
      ),
    );
  }

  void _scanQRCode() async {
    if (kIsWeb) {
      // Mock web QR input
      _processQR("QR_CODE_WEB");
    } else {
      // Mock mobile QR scan
      _processQR("QR_CODE_MOBILE");
    }
  }
}
