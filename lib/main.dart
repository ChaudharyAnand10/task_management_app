import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_system/controller/task_contoller.dart';
import 'package:task_management_system/data/app_database.dart';
import 'package:task_management_system/main_screen.dart';

void main() {
  Get.lazyPut<AppDatabase>(() => AppDatabase(), fenix: true);
  
   Get.lazyPut<TaskController>(() => TaskController(), fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
  
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen() ,
    );
  }
}
