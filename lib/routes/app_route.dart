import 'package:flutter/material.dart';
import 'package:task_wala/common/screens/bottom_nav_bar.dart';
import 'package:task_wala/common/splash_screen.dart';
import 'package:task_wala/features/task/views/home/home_screen.dart';
import 'package:task_wala/features/task/views/notes/screen/add_edit_notes_screen.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/add-task':
        return MaterialPageRoute(builder: (_) => AddEditTaskScreen());
      case '/bottom-nav':
        return MaterialPageRoute(builder: (_) => const BottomNavbar());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
