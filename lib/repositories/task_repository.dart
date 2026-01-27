import 'package:isar/isar.dart';
import 'package:task_manager/model/task_model.dart';

abstract class TaskRepository {
  Future<void> createTask({required TaskModel task});

  Future<List<TaskModel>> readTasks();

  Future<void> updateTask({required TaskModel task});

  Future<void> deleteTask({required int id});


}

class TaskRepositoryImpl implements TaskRepository {
  final Isar _isar;

  TaskRepositoryImpl({required Isar isar}) : _isar = isar;

  Isar get isar => _isar;

  @override
  Future<void> createTask({required TaskModel task}) async {
    await _isar.writeTxn(() async {
      await _isar.taskModels.put(task);
    });
  }

  @override
  Future<void> deleteTask({required int id}) async {
    await _isar.writeTxn(() async {
      await _isar.taskModels.delete(id);
    });
  }

  @override
  Future<List<TaskModel>> readTasks() async {
    return await _isar.taskModels.where().findAll();
  }

  @override
  Future<void> updateTask({required TaskModel task}) async {
    await _isar.writeTxn(() async {
      await _isar.taskModels.put(task);
    });
  }
}

// class Task implements TaskRepository{
//   final Hive _hive;
//
//   Task({required Hive hive}) : _hive = hive;
//   @override
//   void createTask({required TaskModel task}) async {
//     // TODO: implement createTask
//   }
//
//   @override
//   void deleteTask({required int id}) {
//     // TODO: implement deleteTask
//   }
//
//   @override
//   List<TaskModel> readTasks() {
//     // TODO: implement readTasks
//     throw UnimplementedError();
//   }
//
//   @override
//   void updateTask({required TaskModel task}) {
//     // TODO: implement updateTask
//   }
//
// }
