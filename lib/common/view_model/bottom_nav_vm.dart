import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_wala/features/task/views/home/home_screen.dart';
import 'package:task_wala/features/task/views/notes/screen/add_edit_notes_screen.dart';
import 'package:task_wala/features/task/views/profile/screen/profile_screen.dart';

class BottomNavViewModel extends ChangeNotifier {
  final Ref ref;
  BottomNavViewModel({required this.ref});
  int selectedindex = 0;
  final List<Widget> screens =  [
    const HomeScreen(),
    AddEditTaskScreen(),
    const ProfileScreen()
  ];

  changePage(int index) {
    selectedindex = index;
    notifyListeners();
  }
}

final bottomNavVm = ChangeNotifierProvider<BottomNavViewModel>(
    (ref) => BottomNavViewModel(ref: ref));
