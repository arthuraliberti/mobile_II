import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Referência à coleção de tarefas do usuário logado
  CollectionReference get _tasksRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuário não autenticado.');
    return _db.collection('users').doc(uid).collection('tasks');
  }

  // Stream em tempo real das tarefas (ordenadas por data)
  Stream<List<Task>> getTasks() {
    return _tasksRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Criar nova tarefa
  Future<void> addTask(String title, String description) async {
    await _tasksRef.add({
      'title': title,
      'description': description,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Atualizar tarefa existente
  Future<void> updateTask(String taskId, String title, String description) async {
    await _tasksRef.doc(taskId).update({
      'title': title,
      'description': description,
    });
  }

  // Marcar/desmarcar como concluída
  Future<void> toggleTask(String taskId, bool isDone) async {
    await _tasksRef.doc(taskId).update({'isDone': isDone});
  }

  // Deletar tarefa
  Future<void> deleteTask(String taskId) async {
    await _tasksRef.doc(taskId).delete();
  }
}
