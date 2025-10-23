import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';
import '../providers/task_service_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final String petId;

  const AddTaskScreen({super.key, required this.petId});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final titleController = TextEditingController();
  final typeController = TextEditingController();

  Future<void> _saveTask() async {
    final task = PetTask(
      id: const Uuid().v4(),
      title: titleController.text,
      type: typeController.text,
      createdAt: DateTime.now(),
    );

    try {
      await ref.read(taskServiceProvider).createTask(widget.petId, task);
      Navigator.pop(context);
    } catch (e) {
      debugPrint('Erro ao salvar tarefa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar tarefa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
