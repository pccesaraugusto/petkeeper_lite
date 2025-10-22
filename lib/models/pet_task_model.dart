import 'package:cloud_firestore/cloud_firestore.dart';

class PetTask {
  final String id;
  final String petId;
  final String type;
  final String title;
  final DateTime dueDate;
  final String notes;
  final String createdBy;
  final DateTime createdAt;
  final bool done;

  PetTask({
    required this.id,
    required this.petId,
    required this.type,
    required this.title,
    required this.dueDate,
    required this.notes,
    required this.createdBy,
    required this.createdAt,
    required this.done,
  });

  factory PetTask.fromMap(String id, Map<String, dynamic> data) {
    return PetTask(
      id: id,
      petId: data['petId'],
      type: data['type'],
      title: data['title'],
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      notes: data['notes'],
      createdBy: data['createdBy'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      done: data['done'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petId': petId,
      'type': type,
      'title': title,
      'dueDate': dueDate,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'done': done,
    };
  }
}
