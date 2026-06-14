import 'package:flutter/material.dart';
import 'package:task_management_system/view/pages/add_task_page.dart';
import 'package:task_management_system/view/pages/all_task_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [TaskScreen(), AddTaskScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All Task'),

          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Task'),
        ],
      ),
    );
  }
}
