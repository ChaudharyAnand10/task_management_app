import 'package:get/get.dart';
import 'package:drift/drift.dart' as d;
import 'package:task_management_system/data/app_database.dart';

class TaskController extends GetxController {
  RxString selectedPriority = ''.obs;
  Rx<DateTime?> selectedDueDate = Rx<DateTime?>(null);
  RxBool isAdded = false.obs;
  RxList<TaskTable> allTask = <TaskTable>[].obs;
  final AppDatabase db = Get.find<AppDatabase>();


  RxString selectedbtnPriority = 'all'.obs;
  RxList<TaskTable> displayedTasks = <TaskTable>[].obs;



  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllTask();
  }

  Future<bool> addTask(String title, String description) async {
    isAdded.value = true;

    if (title.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter title');
      isAdded.value = false;
      return false;
    }

    if (description.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter title');
      isAdded.value = false;
      return false;
    }

    if (selectedPriority.value.isEmpty) {
      Get.snackbar('Error', 'Please select priority');
      isAdded.value = false;
      return false;
    }

    if (selectedDueDate.value == null) {
      Get.snackbar('Error', 'Please select due date');
      isAdded.value = false;
      return false;
    }

    try {
      await db
          .into(db.taskTables)
          .insert(
            TaskTablesCompanion(
              title: d.Value(title),
              description: d.Value(description),
              priority: d.Value(selectedPriority.value),
              dueDate: d.Value(selectedDueDate.value!),
            ),
          );

      await getAllTask();

      Get.snackbar('Success', 'Task added successfully');

      return true;
    } catch (e) {
      Get.snackbar('Error', 'Task not added');

      return false;
    } finally {
      isAdded.value = false;
    }
  }

  Future<void> getAllTask() async {
     final tasks = await db.select(db.taskTables).get();

    allTask.assignAll(tasks);
    displayedTasks.assignAll(tasks); //

  applyFilters();
  }

  Future<void> toggleTaskStatus(TaskTable task) async {
    try {
      await (db.update(db.taskTables)..where((tbl) => tbl.id.equals(task.id)))
          .write(TaskTablesCompanion(isCompleted: d.Value(!task.isCompleted)));

      await getAllTask();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task status');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await (db.delete(db.taskTables)..where((tbl) => tbl.id.equals(id))).go();

      await getAllTask();

      Get.snackbar('Success', 'Task deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete task');
    }
  }

  Future<void> fetchCategoryTask(String title) async {
     selectedbtnPriority.value = title;
  applyFilters();

  }



  void searchTask(String query) {
  searchQuery.value = query;
  applyFilters();
   }




  void applyFilters() {
  Iterable<TaskTable> filtered = allTask;

  
  if (selectedbtnPriority.value != 'all') {
    filtered = filtered.where(
      (e) =>
          e.priority.toLowerCase() ==
          selectedbtnPriority.value.toLowerCase(),
    );
  }

 
  if (searchQuery.value.trim().isNotEmpty) {
    filtered = filtered.where(
      (e) =>
          e.title.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
          e.description!.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ),
    );
  }

  displayedTasks.assignAll(filtered);
}


Future<void> updateTask({
  required int id,
  required String title,
  required String description,
  required String priority,
  required DateTime dueDate,
}) async {

  await (db.update(db.taskTables)
        ..where((tbl) => tbl.id.equals(id)))
      .write(
    TaskTablesCompanion(
      title: d.Value(title),
      description: d.Value(description),
      priority: d.Value(priority),
      dueDate: d.Value(dueDate),
    ),
  );

  await getAllTask();
}

}
