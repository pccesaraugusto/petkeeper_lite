import 'package:flutter/material.dart';
import '../models/pet_task_model.dart';

class TaskCard extends StatelessWidget {
  final PetTask task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(
          '${task.type} • ${task.dueDate.toLocal().toString().split(' ')[0]}',
        ),
        trailing: Icon(
          task.done ? Icons.check_circle : Icons.radio_button_unchecked,
        ),
      ),
    );
  }
}
