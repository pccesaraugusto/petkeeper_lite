import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

final tasksProvider =
    StreamProvider.family<List<PetTask>, String>((ref, petId) {
  final firestore = FirebaseFirestore.instance;
  final tasksRef = firestore.collection('pets').doc(petId).collection('tasks');

  return tasksRef
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return PetTask(
              id: data['id'] ?? doc.id,
              title: data['title'] ?? '',
              type: data['type'] ?? '',
              createdAt:
                  DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
            );
          }).toList());
});
