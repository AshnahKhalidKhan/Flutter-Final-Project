import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Task extends Equatable
{
  final String eventId;
  final String taskId;
  final String task;
  final bool completed;

  Task
  (
    {
      required this.eventId,
      required this.taskId,
      required this.task,
      required this.completed,
    }
  );
  
  Map<String, dynamic> toJson() 
  {
    return 
    {
      'eventId': eventId,
      'taskId': taskId,
      'task': task,
      'completed': completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) 
  {
    return Task
    (
      eventId: json['eventId'],
      taskId: json['taskId'],
      task: json['task'],
      completed: json['completed'],
    );
  }

  @override
  List<Object?> get props
  {
    return [eventId, taskId, task, completed];
  }

  @override
  bool get stringify => true;

  Task copyWith
  (
    {
      String? eventId,
      String? taskId,
      String? task,
      bool? completed,
    }
  ) 
  {
    return Task
    (
      eventId: eventId ?? this.eventId,
      taskId: taskId ?? this.taskId,
      task: task ?? this.task,
      completed: completed ?? this.completed,
    );
  }

  factory Task.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
  {
    return Task
    (
      eventId: snapshot['eventId'],
      taskId: snapshot['taskId'],
      task: snapshot['task'],
      completed: snapshot['completed'],
    );
  }
}