import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pet_task_model.dart';

class TaskService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<PetTask>> getTasks(String petId) {
    return _firestore
        .collection('pet_tasks')
        .where('petId', isEqualTo: petId)
        .orderBy('dueDate')
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => PetTask.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<void> createTask(PetTask task) async {
    if (task.petId.isEmpty) throw Exception('petId obrigatório');
    if (task.id.isEmpty) throw Exception('task.id obrigatório');
    if (task.title.trim().isEmpty)
      throw Exception('Título da tarefa obrigatório');

    await _firestore.collection('pet_tasks').doc(task.id).set(task.toMap());
  }

  Future<void> updateTask(PetTask task) async {
    if (task.id.isEmpty) throw Exception('task.id obrigatório');
    await _firestore.collection('pet_tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    if (taskId.isEmpty) throw Exception('taskId obrigatório');
    await _firestore.collection('pet_tasks').doc(taskId).delete();
  }
}
