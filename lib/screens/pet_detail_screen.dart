import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/pet_model.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import 'add_task_screen.dart';

class PetDetailScreen extends ConsumerWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  Future<void> _notifyAndAddTask(BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final functions = FirebaseFunctions.instance;
    final taskId = const Uuid().v4();

    debugPrint('🔔 Iniciando notificação e criação de tarefa...');

    try {
      // Etapa 1: Chamar função callable
      debugPrint('📡 Chamando função notifyFamily...');
      final callable = functions.httpsCallable('notifyFamily');
      final result = await callable.call({
        'petId': pet.id,
        'message': 'Nova atualização para ${pet.name}',
      });

      debugPrint('✅ Notificação enviada: ${result.data}');

      // Etapa 2: Criar tarefa
      final novaTarefa = {
        'id': taskId,
        'title': 'Tomar banho',
        'type': 'Higiene',
        'createdAt': DateTime.now().toIso8601String(),
      };

      debugPrint('📝 Salvando tarefa: $novaTarefa');

      await firestore
          .collection('pets')
          .doc(pet.id)
          .collection('tasks')
          .doc(taskId)
          .set(novaTarefa);

      debugPrint('✅ Tarefa adicionada com sucesso.');

      _showSnackBar(context, 'Família avisada e tarefa adicionada!');
    } catch (e, stackTrace) {
      debugPrint('❌ Erro ao notificar ou adicionar tarefa: $e');
      debugPrint('📋 Stack trace:\n$stackTrace');
      _showSnackBar(context, 'Erro ao avisar a família ou salvar tarefa.');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(petId: pet.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksProvider(pet.id));

    return Scaffold(
      appBar: AppBar(title: Text(pet.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => _notifyAndAddTask(context),
              icon: const Icon(Icons.notifications_active),
              label: const Text('Avisar Família e Adicionar Tarefa'),
            ),
          ),
          Expanded(
            child: tasksAsync.when(
              data: (tasks) => tasks.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa registrada.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final PetTask task = tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.type),
                          leading: const Icon(Icons.task),
                        );
                      },
                    ),
              loading: () {
                debugPrint('🔄 Carregando tarefas...');
                return const Center(child: CircularProgressIndicator());
              },
              error: (error, _) {
                debugPrint('❌ Erro ao carregar tarefas: $error');
                return Center(
                  child: Text('Erro ao carregar tarefas: $error'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        child: const Icon(Icons.add),
        tooltip: 'Adicionar Tarefa',
      ),
    );
  }
}
