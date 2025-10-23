import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Future<void> _createUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .useAuthEmulator('localhost', 9099); // conecta ao emulador
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'pc@gmail.com',
        password: '123456',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Usuário criado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Erro ao criar usuário: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Usuário')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _createUser(context),
          child: const Text('Criar usuário de teste'),
        ),
      ),
    );
  }
}
