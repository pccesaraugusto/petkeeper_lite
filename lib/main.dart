import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'firebase_options.dart'; // Gerado pelo Firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Configuração dos emuladores Firebase
  //const emulatorHost = 'localhost';

  /*FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
  FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
  FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);*/

  runApp(const ProviderScope(child: PetKeeperApp()));
}

class PetKeeperApp extends StatelessWidget {
  const PetKeeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetKeeper Lite',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const LoginScreen(),
    );
  }
}
