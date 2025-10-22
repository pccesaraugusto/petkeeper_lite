import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pet_model.dart';
import '../providers/task_provider.dart';
import '../services/notification_service.dart';
import 'add_task_screen.dart';

class PetDetailScreen extends ConsumerWidget {
  final Pet pet;
  const PetDetailScreen({super.key, required this.pet});

  void notifyFamily(BuildContext context, WidgetRef ref) async {
    final service = NotificationService();
    await service.notifyFamily(pet.id, 'Nova atualização para ${pet.name}');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Família avisada!')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider(pet.id));

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => notifyFamily(context, ref),
            child: const Text('Avisar Família'),
          ),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) => ListView(
                children: tasks
                    .map(
                      (t) => ListTile(
                        title: Text(t.title),
                        subtitle: Text(t.type),
                      ),
                    )
                    .toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Erro ao carregar tarefas: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddTaskScreen(petId: pet.id)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
