import 'package:flutter/material.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/login_screen.dart';

import 'ui/screens/splash_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorGlobalKey = GlobalKey();

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorGlobalKey,
      home: const SplashScreen(),
    );
  }
}
