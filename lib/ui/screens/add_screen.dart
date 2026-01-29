import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/logic/category_cubit.dart';
import 'package:task_manager/logic/task_cubit.dart';
import 'package:task_manager/model/task_model.dart';
import '../../core/utils.dart';
import '../../model/category.dart';
import '../widgets/app_button.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/priority_widget.dart';
import '../widgets/text_input_field_widget.dart';

class AddScreen extends StatefulWidget {
  final TaskModel? task;

  const AddScreen({super.key, this.task, });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;

  late DateTime _selectedDateTime ;

  late int selectPriority;
  String? _selectedCategoryId;


  bool get isEditMode => widget.task != null;

  @override
  void initState() {
    super.initState();
    if(isEditMode){
      titleController = TextEditingController(text: widget.task!.title);
      descController = TextEditingController(text: widget.task!.description);
      _selectedDateTime = widget.task!.dueDate;
      selectPriority = widget.task!.priority;
      _selectedCategoryId = widget.task!.categoryId;
    } else{
      titleController = TextEditingController();
      descController = TextEditingController();
      _selectedDateTime = DateTime.now();
      selectPriority = 0;
      _selectedCategoryId = null; // Or default if preferred
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Новая задача'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputFieldWidget(
                label: 'Title',
                hint: 'Добавьте название задачи',
                controller: titleController,
              ),
              SizedBox(height: 24),
              TextInputFieldWidget(
                label: 'Описание ',
                hint: 'добавьте описание',
                maxLines: 4,
                controller: descController,
              ),
              SizedBox(height: 24),

              Text('Категория', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CategoryLoaded) {
                    return Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedCategoryId,
                            items: state.categories.map((e) {
                              return DropdownMenuItem(
                                value: e.name, // Using name as ID for now based on TaskModel schema, ideally use ID
                                child: Text(e.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategoryId = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Выберите категорию',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _showAddCategoryDialog(context),
                        )
                      ],
                    );
                  } else if (state is CategoryError) {
                    return Text('Ошибка: ${state.message}');
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 24),

              PriorityWidget(
                selectPriority: selectPriority,
                onTap: (int p1) {
                  setState(() {
                    selectPriority = p1;
                  });
                },
              ),
              SizedBox(height: 24),
              DatePickerWidget(
                onTap: () {
                  showDateDialog();
                },
                selectedDay: _selectedDateTime,
              ),
              SizedBox(height: 48),
              AppButton(
                title: isEditMode ? 'Обновить задачу' :  'Добавить задачу',
                onPressed: () {
                  submit();
                },
              ),
              SizedBox(height: 20), // Extra padding at bottom
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController categoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить категорию'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Название категории'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (categoryController.text.isNotEmpty) {
                  context.read<CategoryCubit>().createCategory(name: categoryController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Создать'),
            ),
          ],
        );
      },
    );
  }

  void showDateDialog() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDateTime = picked);
  }

  void submit() {
    if (titleController.text.isEmpty) return;


    if(isEditMode){
      final updateTask = widget.task!.copyWith(
        title: titleController.text,
        description: descController.text,
        dueDate: _selectedDateTime,
        priority: selectPriority,
        categoryId: _selectedCategoryId ?? 'General', // Default if null
      );

      context.read<TaskCubit>().updateTask(task: updateTask);
      AppNavigation.pop(context);
    } else{
      final task = TaskModel(
        title: titleController.text,
        description: descController.text,
        dueDate: _selectedDateTime,
        priority: selectPriority,
        categoryId: _selectedCategoryId ?? 'General', // Default if null
        createdAt: DateTime.now(),
      );

      context.read<TaskCubit>().addTask(taskModel: task);

      AppNavigation.pop(context);
    }
  }
}
