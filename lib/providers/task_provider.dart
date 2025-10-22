import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/task_service.dart';
import '../models/pet_task_model.dart';

final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

/// Stream de tarefas por petId, com autoDispose para liberar recursos quando não usado
final tasksProvider =
    StreamProvider.autoDispose.family<List<PetTask>, String>((ref, petId) {
  final service = ref.watch(taskServiceProvider);
  return service.getTasks(petId);
});
