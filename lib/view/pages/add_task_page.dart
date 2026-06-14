import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';
import 'package:task_management_system/view/widgets/select_date_screen.dart';
import 'package:task_management_system/view/widgets/radio_widget.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController taskController = Get.find<TaskController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void clearFields() {
  titleController.clear();
  descriptionController.clear();

  taskController.selectedPriority.value = '';
  taskController.selectedDueDate.value = null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: titleController,
        decoration: InputDecoration(
          labelText: 'Title',
          hintText: 'Enter task title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      const SizedBox(height: 16),

      TextField(
        controller: descriptionController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Description',
          hintText: 'Enter task description',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      const SizedBox(height: 20),

      const Text(
        'Priority',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 10),

      RadioWidget(title: 'High', value: 'high'),
      RadioWidget(title: 'Medium', value: 'medium'),
      RadioWidget(title: 'Low', value: 'low'),

      const SizedBox(height: 20),

      DateScreen(),

      const SizedBox(height: 30),

      Obx(
        () => SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: taskController.isAdded.value
                ? null
                : () async {
                    final isSuccess = await taskController.addTask(
                      titleController.text,
                      descriptionController.text,
                    );

                    if (isSuccess) {
                      clearFields();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: taskController.isAdded.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    ],
  ),
),
    );
  }
}
