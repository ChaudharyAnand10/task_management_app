import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';

class DateScreen extends StatelessWidget {
 DateScreen({super.key});
 final TaskController taskController = Get.find<TaskController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
        'Due Date',
        style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
        ),
      ),
      
      Obx(
        () => ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(
        taskController.selectedDueDate.value == null
            ? 'Select Due Date'
            : taskController.selectedDueDate.value!
                .toString()
                .split(' ')[0], // YYYY-MM-DD
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
      
        if (pickedDate != null) {
          taskController.selectedDueDate.value = pickedDate;
        }
      },
        ),
      ),
        ],
      ),
    );
  }
}
