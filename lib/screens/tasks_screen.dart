import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.pets, color: Colors.white, size: 32),
                  SizedBox(width: 10),
                  Text(
                    'PetKeeper Menu',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.task_alt, color: Colors.blue),
                    title: const Text('Tarefas'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/tasks');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications_active,
                        color: Colors.blue),
                    title: const Text('Notificar Família'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/notify');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Sair'),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à tela de tarefas!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
