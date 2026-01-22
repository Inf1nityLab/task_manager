import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/repositories/task_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(TaskInitial());

  void order() async {
    try {
      emit(TaskLoading());

      final food = await _taskRepository.readTasks();

      emit(TaskSuccess(task: food));
    } catch (e) {
      emit(TaskError(error: 'произошло ошибка загрузки$e'));
    }
  }

  void addTask({required TaskModel taskModel}) async {
    try {
      //emit(TaskLoading());
      await _taskRepository.createTask(task: taskModel);
      order();
    } catch (e) {
      emit(TaskError(error: 'Не смогли добавить задачу$e'));
    }
  }

  void updateTask({required TaskModel task}) async {
    try {
      await _taskRepository.updateTask(task: task);
      order();
    } catch (e) {
      emit(TaskError(error: 'Не смогли обновить задачу $e'));
    }
  }

  void deleteTask({required int id}) async{
    try {
      await _taskRepository.deleteTask(id: id);
      order();
    } catch(e){
      emit(TaskError(error: 'Не смогли удалить задачу $e'));
    }
  }
}
