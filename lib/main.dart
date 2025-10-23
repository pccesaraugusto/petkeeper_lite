import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Telas do app
import 'package:petkeeper_lite/screens/login_screen.dart';
import 'package:petkeeper_lite/screens/tasks_screen.dart';
import 'package:petkeeper_lite/screens/notify_family_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAwaTrUfTnp0Y6jmLRxq_4Ahlwt6JrCR0s',
      authDomain: 'petkeepr-ad816.firebaseapp.com',
      projectId: 'petkeepr-ad816',
      storageBucket: 'petkeepr-ad816.appspot.com',
      messagingSenderId: '317771367093',
      appId: '1:317771367093:web:6c5ed723c78b968c3c74fc',
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetKeeper Lite',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/tasks': (context) => const TasksScreen(),
        '/notify': (context) => const NotifyFamilyScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const TasksScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
