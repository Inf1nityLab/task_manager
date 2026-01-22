import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils.dart';
import 'package:task_manager/logic/task_cubit.dart';
import 'package:task_manager/ui%20/screens/add_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskError) {
            return Center(child: Text(state.error));
          } else if (state is TaskSuccess) {
            return state.task.isEmpty
                ? Center(child: Text('Задач пока нету'))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: state.task.length,
                      itemBuilder: (context, index) {
                        final task = state.task[index];
                        return ListTile(
                          title: Text(task.title, maxLines: 3),
                          subtitle: Text(task.description),
                          trailing: Row(
                            mainAxisSize: .min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  AppNavigation.push(
                                    context,
                                    AddScreen(task: task),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),

                              IconButton(
                                onPressed: () {
                                  _showDialog(context, task.id);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                    ),
                  );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<TaskCubit>().order();
                },
                child: Text('Заказать'),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigation.push(context, AddScreen());
        },
      ),
    );
  }

  void _showDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Вы реально хотите удалить информацию?'),

          actions: [
            TextButton(
              onPressed: () {
                AppNavigation.pop(context);
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<TaskCubit>().deleteTask(id: id);
                AppNavigation.pop(context);
              },
              child: Text('yes'),
            ),
          ],
        );
      },
    );
  }
}

// BlocProvider
// BlocBuilder
// state event - emit
// BlocConsumer
// BlocListener
// BlocRepository
