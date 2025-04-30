import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/home_screen.dart';
import 'data/repositories/vehicle_repository.dart';

import 'presentation/screens/booking_screen.dart';
import 'presentation/screens/profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check connection
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VehicleRepository()),
      ],
      child: const VishareApp(),
    ),
  );
}

class VishareApp extends StatelessWidget {
  const VishareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViShare',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true, // Aggiunto per Material 3
      ),
      home: const HomeScreen(),
      routes: {
        '/booking': (context) => const BookingScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
