import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';
import 'package:task_management_system/view/widgets/elevated_buttons.dart';
import 'package:task_management_system/view/widgets/single_task_page.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskController taskController = Get.find<TaskController>();
  final TextEditingController serchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Tasks"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.black26, width: 2),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search task',
                  contentPadding: EdgeInsetsGeometry.all(2),
                ),
                controller: serchController,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                title: 'all',
               
              ),
              CustomElevatedButton(title: 'high',),
              CustomElevatedButton(title: 'medium', ),
              CustomElevatedButton(title: 'low', ),
            ],
          ),

          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: taskController.allTask.length,
                itemBuilder: (context, index) {
                  final task = taskController.allTask[index];

                  return SingleTaskScreen(tasktable: task);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
