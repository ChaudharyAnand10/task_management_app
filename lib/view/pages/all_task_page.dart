import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';
import 'package:task_management_system/view/pages/add_task_page.dart';
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Colors.black12,
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: TextField(
  controller: serchController,
  onChanged: (value) {
    taskController.searchTask(value);
  },
  decoration: const InputDecoration(
    hintText: 'Search task...',
    prefixIcon: Icon(Icons.search),
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(
      vertical: 14,
    ),
  ),
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

          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //       itemCount: taskController.displayedTasks.length,
          //       itemBuilder: (context, index) {
          //         final task = taskController.displayedTasks[index];

          //         return SingleTaskScreen(tasktable: task);
          //       },
          //     ),
          //   ),
          // ),



          Expanded(
  child: Obx(
    () => ListView.builder(
      itemCount: taskController.displayedTasks.length,

      itemBuilder: (context, index) {

        final task =
            taskController.displayedTasks[index];

        return Dismissible(

          key: ValueKey(task.id),

          background: Container(
            color: const Color.fromARGB(255, 167, 76, 69),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),

          onDismissed: (_) async {

            final deletedTask = task;

            taskController.displayedTasks.remove(task);

            final result =
                await ScaffoldMessenger.of(context)
                    .showSnackBar(

              SnackBar(
                content: Text('Task deleted'),

                duration: Duration(seconds: 3),

                action: SnackBarAction(
                  label: 'UNDO',

                  onPressed: () {
                    taskController.displayedTasks
                        .insert(
                      index,
                      deletedTask,
                    );
                  },
                ),
              ),

            ).closed;

            if (result !=
                SnackBarClosedReason.action) {

              await taskController.deleteTask(
                deletedTask.id,
              );

            }
          },

          child: InkWell(
  onTap: () {
    Get.to(
      () => AddTaskScreen(
        task: task,
      ),
    );
  },
  child: SingleTaskScreen(
    tasktable: task,
  ),
),
        );
      },
    ),
  ),
)
        ],
      ),
    );
  }
}
