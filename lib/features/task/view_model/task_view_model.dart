import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_wala/database/task_database/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final Ref ref;
  TaskViewModel({required this.ref});
  List<TaskDataModel> taskDataList = [];
  final taskTileController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();
  final taskTimeController = TextEditingController();

  DateTime taskDate = DateTime.now().toLocal();
  TimeOfDay taskTime = TimeOfDay.now();

  DateTime selectedDate = DateTime.now().toLocal();

  bool isRepeat = false;
  bool isShowNotification = true;

  bool isTaskAdding = false;
  bool isTaskloading = false;

  bool isTaskDeleting = false;

  addTask(TaskDataModel model) async {
    try {
      isTaskAdding = true;
      Box box = await Hive.openBox<TaskDataModel>("Task");
      box.add(model);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isTaskAdding = false;
      notifyListeners();
    }
  }

  Future getTask() async {
    try {
      isTaskloading = true;
      final box = await Hive.openBox<TaskDataModel>("Task");
      taskDataList = box.values.toList();

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isTaskloading = false;
      notifyListeners();
    }
  }

  deleteaddTask(int position) async {
    try {
      isTaskDeleting = true;
      final box = Hive.box<TaskDataModel>("Task");
      box.deleteAt(position);
      taskDataList.removeAt(position);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isTaskDeleting = false;
      notifyListeners();
    }
  }

  editaddTask(int position, TaskDataModel model) async {
    try {
      isTaskAdding = true;
      var box = await Hive.openBox<TaskDataModel>("Task");
      box.putAt(position, model);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isTaskAdding = true;
      notifyListeners();
    }
  }

  setDate(DateTime time) {
    taskDate = time;
    taskDateController.text = DateFormat('dd MMM, yyyy').format(taskDate);
    notifyListeners();
  }

  setTime(TimeOfDay time, BuildContext context) {
    taskTime = time;
    taskTimeController.text =
        TimeOfDay(hour: time.hour, minute: time.minute).format(context);
    notifyListeners();
  }

  setRepeat(bool value) {
    isRepeat = value;
    notifyListeners();
  }

  setShowNotification(bool value) {
    isShowNotification = value;
    notifyListeners();
  }

  setSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    notifyListeners();
  }
}

final taskViewModel =
    ChangeNotifierProvider<TaskViewModel>((ref) => TaskViewModel(ref: ref));
