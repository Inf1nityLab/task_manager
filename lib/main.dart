import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/logic/task_cubit.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/ui/screens/add_screen.dart';
import 'package:task_manager/ui/screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final direction = await getApplicationCacheDirectory();

  final taskSafe = await Isar.open([
    TaskModelSchema,
  ], directory: direction.path);
  final taskRepository = TaskRepositoryImpl(isar: taskSafe);

  runApp(MyApp(taskRepository: taskRepository));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;

  const MyApp({super.key, required this.taskRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(taskRepository: taskRepository)..order(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const TaskScreen(),
      ),
    );
  }
}


