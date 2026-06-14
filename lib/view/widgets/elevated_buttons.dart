import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  final TaskController taskController = Get.find<TaskController>();

  CustomElevatedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Obx(
          ()=> ElevatedButton(
            onPressed: () {
  taskController.fetchCategoryTask(title);
},
              
            
            style: ElevatedButton.styleFrom(
              elevation: 1,
              backgroundColor: taskController.selectedbtnPriority.value == title
                  ? Colors.brown
                  : const Color.fromARGB(255, 230, 228, 233),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
