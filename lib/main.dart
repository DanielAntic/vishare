import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'presentation/screens/home_screen.dart';
import 'data/repositories/vehicle_repository.dart';

import 'presentation/screens/booking_screen.dart';
import 'presentation/screens/profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

//import 'data/repositories/booking_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:vishare/presentation/screens/signin_screen.dart';

import 'data/repositories/user_repository.dart';


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
        Provider(create: (_) => UserRepository()),
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
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      home: const AuthCheckScreen(),
      routes: {
        '/booking': (context) => const BookingScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}


class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return const HomeScreen();
        return const SignInScreen();
      },
    );
  }
}
