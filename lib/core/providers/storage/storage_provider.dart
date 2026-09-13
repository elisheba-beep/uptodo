import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';

part 'storage_provider.g.dart';

@riverpod
FutureOr<JsonSqFliteStorage> taskStorage(Ref ref) async{
  return JsonSqFliteStorage.open(join(await getDatabasesPath(), 'riverpod.db'));
}