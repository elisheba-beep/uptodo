import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/constant/firebase_constants.dart';
import 'package:uptodo/features/tasks/domain/repositories/firestore_tasks_repository.dart';
import 'package:uptodo/features/tasks/domain/repositories/tasks_repository.dart';

part 'tasks_repository_provider.g.dart';

@riverpod
TasksRepository tasksRepository(Ref ref) {
  final uid = fbAuth.currentUser?.uid;
  if (uid == null) throw StateError('Not signed in');
  return FirestoreTasksRepository(usersCollection.doc(uid).collection('tasks'));
}
