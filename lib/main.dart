import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/logic/category_cubit.dart';
import 'package:task_manager/logic/task_cubit.dart';
import 'package:task_manager/model/category.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/repositories/category_repositories.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/ui/screens/add_screen.dart';
import 'package:task_manager/ui/screens/task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final direction = await getApplicationCacheDirectory();

  final isar = await Isar.open([
    TaskModelSchema,
    CategorySchema,
  ], directory: direction.path);

  final taskRepository = TaskRepositoryImpl(isar: isar);
  final categoryRepository = CategoryRepositoriesImpl(isar: isar);

  runApp(MyApp(
    taskRepository: taskRepository,
    categoryRepository: categoryRepository,
  ));
}

class MyApp extends StatelessWidget {
  final TaskRepository taskRepository;
  final CategoryRepositories categoryRepository;

  const MyApp({
    super.key,
    required this.taskRepository,
    required this.categoryRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit(taskRepository: taskRepository)..order(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(categoriesRepositories: categoryRepository)..loadCategories(),
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


