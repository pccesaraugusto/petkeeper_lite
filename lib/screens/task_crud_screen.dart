import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskCrudScreen extends StatefulWidget {
  const TaskCrudScreen({super.key});

  @override
  State<TaskCrudScreen> createState() => _TaskCrudScreenState();
}

class _TaskCrudScreenState extends State<TaskCrudScreen> {
  final TextEditingController _taskController = TextEditingController();
  String? _editingTaskId;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _addOrUpdateTask() async {
    final text = _taskController.text.trim();
    if (text.isEmpty) return;

    if (_editingTaskId == null) {
      await FirebaseFirestore.instance.collection('tarefas').add({
        'descricao': text,
        'userId': userId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('tarefas')
          .doc(_editingTaskId)
          .update({
        'descricao': text,
      });
    }

    _taskController.clear();
    setState(() => _editingTaskId = null);
  }

  Future<void> _deleteTask(String id) async {
    await FirebaseFirestore.instance.collection('tarefas').doc(id).delete();
  }

  void _startEditing(String id, String descricao) {
    setState(() {
      _editingTaskId = id;
      _taskController.text = descricao;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tarefasStream = FirebaseFirestore.instance
        .collection('tarefas')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText:
                    _editingTaskId == null ? 'Nova tarefa' : 'Editar tarefa',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addOrUpdateTask,
              child: Text(_editingTaskId == null ? 'Adicionar' : 'Atualizar'),
            ),
            const SizedBox(height: 20),
            const Text('Minhas Tarefas', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: tarefasStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty)
                    return const Text('Nenhuma tarefa encontrada.');

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final descricao = doc['descricao'] ?? '';
                      return ListTile(
                        title: Text(descricao),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.edit, color: Colors.orange),
                              onPressed: () => _startEditing(doc.id, descricao),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(doc.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
