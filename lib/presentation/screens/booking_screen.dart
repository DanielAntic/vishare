import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:vishare/data/repositories/vehicle_repository.dart';

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
}
