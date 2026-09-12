// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  title: json['title'] as String,
  desc: json['desc'] as String?,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  tag: json['tag'] as String,
  priority: (json['priority'] as num).toInt(),
  completed: json['completed'] as bool? ?? false,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'desc': instance.desc,
  'updatedAt': instance.updatedAt.toIso8601String(),
  'tag': instance.tag,
  'priority': instance.priority,
  'completed': instance.completed,
};
