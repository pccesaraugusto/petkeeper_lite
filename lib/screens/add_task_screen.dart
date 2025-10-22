import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/pet_task_model.dart';
import '../providers/task_provider.dart';
import '../providers/auth_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final String petId;
  const AddTaskScreen({super.key, required this.petId});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final titleController = TextEditingController();
  final notesController = TextEditingController();
  String type = 'vaccine';
  DateTime dueDate = DateTime.now();

  void saveTask() async {
    final uid = ref.read(currentUserProvider)?.uid ?? '';
    final task = PetTask(
      id: const Uuid().v4(),
      petId: widget.petId,
      type: type,
      title: titleController.text,
      dueDate: dueDate,
      notes: notesController.text,
      createdBy: uid,
      createdAt: DateTime.now(),
      done: false,
    );
    await ref.read(taskServiceProvider).createTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: 'vaccine', child: Text('Vacina')),
                DropdownMenuItem(value: 'grooming', child: Text('Banho/Tosa')),
                DropdownMenuItem(value: 'other', child: Text('Outro')),
              ],
              onChanged: (val) => setState(() => type = val!),
            ),
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título')),
            TextField(
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notas')),
            ElevatedButton(onPressed: saveTask, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
