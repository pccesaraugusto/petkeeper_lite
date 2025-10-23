import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createTask(String petId, PetTask task) async {
    await _db
        .collection('pets')
        .doc(petId)
        .collection('tasks')
        .doc(task.id)
        .set({
      'id': task.id,
      'title': task.title,
      'type': task.type,
      'createdAt': task.createdAt.toIso8601String(),
    });
  }
}
