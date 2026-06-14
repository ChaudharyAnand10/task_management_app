import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';

class RadioWidget extends StatelessWidget {
  RadioWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RadioListTile<String>(
        title: Text(title),
        value: value,
        groupValue: taskController.selectedPriority.value,
        onChanged: (selectedValue) {
          taskController.selectedPriority.value = selectedValue!;
        },
      ),
    );
  }
}