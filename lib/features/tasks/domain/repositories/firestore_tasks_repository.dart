import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/domain/repositories/tasks_repository.dart';

class FirestoreTasksRepository extends TasksRepository {
  FirestoreTasksRepository(this._col);
  final CollectionReference<Map<String, dynamic>> _col;

  @override
  Future<List<Task>> getTasks() async {
    final snap = await _col.get();
    return [for (final d in snap.docs) Task.fromJson(d.data())];
  }

  @override
  Future<void> addTask({required Task task}) =>
      _col.doc(task.id).set(task.toJson());

  @override
  Future<void> editTask({
    required String id,
    String? title,
    String? desc,
    DateTime? updatedAt,
    String? tag,
    int? priority,
  }) {
    final data = <String, dynamic>{
      'title': ?title,
      'desc': ?desc,
      if (updatedAt != null) 'updatedAt': updatedAt.toIso8601String(),
      'tag': ?tag,
      'priority': ?priority,
    };
    if (data.isEmpty) return Future.value();
    return _col.doc(id).update(data);
  }

  @override
  Future<void> toggleTask({required String id}) async {
    final doc = _col.doc(id);
    final snap = await doc.get();
    final current = (snap.data()?['completed'] as bool?) ?? false;
    await doc.update({'completed': !current});
  }

  @override
  Future<void> removeTask({required String id}) => _col.doc(id).delete();
}
