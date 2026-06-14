import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_system/controller/task_contoller.dart';
import 'package:task_management_system/data/app_database.dart';
import 'package:task_management_system/utils/constants.dart';

class SingleTaskScreen extends StatelessWidget {
  final TaskTable tasktable;
  final VoidCallback? onDelete;
  final VoidCallback? onStatusTap;

  const SingleTaskScreen({
    super.key,
    required this.tasktable,
    this.onDelete,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tasktable.isCompleted
            ? Colors.green
            : const Color.fromARGB(255, 230, 228, 233),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
         GestureDetector(
  onTap: () {
    taskController.toggleTaskStatus(tasktable);
  },
  child:AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  height: 22,
  width: 22,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: tasktable.isCompleted
        ? Colors.green
        : Colors.transparent,
    border: Border.all(
      color: tasktable.isCompleted
          ? Colors.black
          : Colors.grey,
      width: 2,
    ),
  ),
  child: tasktable.isCompleted
      ? const Icon(Icons.check, size: 14)
      : null,
)
), 

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tasktable.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.priorityBgColor[tasktable.priority],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tasktable.priority,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                
                Text(
                  tasktable.description ?? "",
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                ),

                const SizedBox(height: 14),

              
                Row(
                  children: [
                    /// Status
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: tasktable.isCompleted
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tasktable.isCompleted ? "Completed" : "Pending",
                        style: TextStyle(
                          color: tasktable.isCompleted
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            DateFormat(
                              'MMM dd, yyyy',
                            ).format(tasktable.dueDate),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    
                    IconButton(
                      onPressed: () {
                        taskController.deleteTask(tasktable.id);
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
