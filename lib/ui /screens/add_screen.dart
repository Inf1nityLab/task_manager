import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/logic/task_cubit.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/ui%20/widgets/app_button.dart';
import 'package:task_manager/ui%20/widgets/date_picker_widget.dart';
import 'package:task_manager/ui%20/widgets/priority_widget.dart';
import 'package:task_manager/ui%20/widgets/text_input_field_widget.dart';

import '../../core/utils.dart';

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


  bool get isEditMode => widget.task != null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(isEditMode){
      titleController = TextEditingController(text: widget.task!.title);
      descController = TextEditingController(text: widget.task!.description);
      _selectedDateTime = widget.task!.dueDate;
      selectPriority = widget.task!.priority;
    } else{
      titleController = TextEditingController();
      descController = TextEditingController();
      _selectedDateTime = DateTime.now();
      selectPriority = 0;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInputFieldWidget(
              label: 'Tilte',
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
          ],
        ),
      ),
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
        priority: selectPriority
      );

      context.read<TaskCubit>().updateTask(task: updateTask);
      AppNavigation.pop(context);
    } else{
      final task = TaskModel(
        title: titleController.text,
        description: descController.text,
        dueDate: _selectedDateTime,
        priority: selectPriority,
        categoryId: 'default',
        createdAt: DateTime.now(),
      );

      context.read<TaskCubit>().addTask(taskModel: task);

      AppNavigation.pop(context);
    }
  }
}
