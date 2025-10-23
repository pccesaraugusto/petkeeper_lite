import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotifyFamilyScreen extends StatefulWidget {
  const NotifyFamilyScreen({super.key});

  @override
  State<NotifyFamilyScreen> createState() => _NotifyFamilyScreenState();
}

class _NotifyFamilyScreenState extends State<NotifyFamilyScreen> {
  final petIdController = TextEditingController();
  final messageController = TextEditingController();
  String result = '';

  Future<void> _notifyFamily() async {
    try {
      await FirebaseFirestore.instance.collection('notificacoes').add({
        'petId': petIdController.text.trim(),
        'mensagem': messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        result = '✅ Notificação salva no Firestore!';
      });
    } catch (e) {
      setState(() {
        result = '❌ Erro ao salvar: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificar Família')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: petIdController,
              decoration: const InputDecoration(labelText: 'ID do Pet'),
            ),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(labelText: 'Mensagem'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _notifyFamily,
              child: const Text('Salvar Notificação'),
            ),
            const SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}
