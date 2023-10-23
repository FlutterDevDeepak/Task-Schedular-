import 'package:task_wala/database/task_database/task_model.dart';

class AddEditTaskArguments {
  final TaskDataModel? model;
  final bool isEdit;
  final int? index;

  AddEditTaskArguments(this.model, this.index, {this.isEdit = false});
}
