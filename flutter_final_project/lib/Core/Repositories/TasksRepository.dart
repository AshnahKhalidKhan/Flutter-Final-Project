import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_final_project/models/TaskModel.dart';

class TasksRepository 
{
  final FirebaseFirestore firebaseFirestore;
  TasksRepository({required this.firebaseFirestore});

  Future<void> createTaskFunctionInTaskRepositoryFile
  (
    {
      required String eventId,
      required String task,
    }
  )
  async 
  {
    try 
    {
      final String taskId = FirebaseFirestore.instance.collection('Tasks').doc().id;
      final Task newTask = Task
      (
        eventId: eventId,
        taskId: taskId,
        task: task,
        completed: false
      );
      await FirebaseFirestore.instance.collection('Tasks').doc().set(newTask.toJson());
    }
    catch (e) 
    {
      print('Error in TaskRepository, createTask: $e');
    }
  }

  Stream<List<Task>> readTaskFunctionInTaskRepositoryFile(String eventId) 
  {
    try 
    {
      return FirebaseFirestore.instance.collection('Tasks').where('eventId', isEqualTo: eventId).snapshots().map
      (
        (querySnapshot) =>
        querySnapshot.docs.map((e) => Task.fromSnapshot(e)).toList()
      );
    } 
    catch (e) 
    {
      print('Error in TaskRepository, readTask: $e');
      return Stream<List<Task>>.empty();
    }
  }

  Future<void> updateTaskFunctionInTaskRepositoryFile(Task task)
  async 
  {
    try 
    {
      final updatedTask = Task
      (
        eventId: task.eventId,
        taskId: task.taskId, 
        task: task.task, 
        completed: task.completed
      ).toJson();
      await FirebaseFirestore.instance.collection('Tasks').doc(task.taskId).update(updatedTask);
    }
    catch (e) 
    {
      print('Error in TaskRepository, updateTask: $e');
    }
  }

  Future<void> deleteTaskFunctionInTaskRepositoryFile(String taskId)
  async 
  {
    try 
    {
      await FirebaseFirestore.instance.collection('Tasks').doc(taskId).delete();
    }
    catch (e) 
    {
      print('Error in TaskRepository, deleteTask: $e');
    }
  }
}