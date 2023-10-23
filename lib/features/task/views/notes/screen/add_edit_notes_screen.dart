import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_wala/common/widgets/app_text.dart';
import 'package:task_wala/constant/app_colors.dart';
import 'package:task_wala/constant/routes_name.dart';
import 'package:task_wala/database/task_database/task_model.dart';
import 'package:task_wala/features/task/view_model/task_view_model.dart';
import 'package:task_wala/services/notification/notification_services.dart';
import '../../../../../common/view_model/bottom_nav_vm.dart';
import '../../../../../common/widgets/my_button.dart';
import '../../../../../common/widgets/my_textfield.dart';

class AddEditTaskScreen extends HookConsumerWidget {
  final bool isEdit;
  final TaskDataModel? model;
  final int? index;
  AddEditTaskScreen({super.key, this.isEdit = false, this.model, this.index});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskViewModel);
    final bottomViewModel = ref.watch(bottomNavVm);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (isEdit) {
          viewModel.taskDateController.text =
              DateFormat('dd MMM, yyyy').format(model!.date);
          viewModel.taskDescriptionController.text =
              model?.taskDescription ?? "";
          viewModel.taskTileController.text = model?.taskName ?? "";
          viewModel.isRepeat = model?.isRepeat ?? false;
        } else {
          viewModel.taskDateController.text =
              DateFormat('dd MMM, yyyy').format(viewModel.taskDate);
          viewModel.taskTimeController.text =
              DateFormat('hh:mm:aa').format(viewModel.taskDate);
        }
      });

      return;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.bottomNav, (route) => false);

            bottomViewModel.changePage(1);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: AppText(
          text: isEdit == true ? "Edit task" : "Add Task",
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          // key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AppCustomTextField(
                controller: viewModel.taskTileController,
              ),
              const SizedBox(
                height: 20,
              ),
              AppCustomTextField(
                controller: viewModel.taskDescriptionController,
                hint: "Enter task description",
                maxLines: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              AppCustomTextField(
                prefix: const Icon(
                  Icons.calendar_month,
                  color: AppColor.orangeColor,
                ),
                onTap: () async {
                  DateTime? time = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 50),
                  );
                  viewModel.setDate(
                    time ?? DateTime.now(),
                  );
                  debugPrint('datePrint ${DateFormat.yMd().format(time!)}');
                },
                controller: viewModel.taskDateController,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                      side: const BorderSide(color: AppColor.orangeColor),
                      activeColor: AppColor.orangeColor,
                      value: viewModel.isRepeat,
                      focusColor: AppColor.orangeColor,
                      onChanged: (v) {
                        viewModel.setRepeat(v ?? true);
                      }),
                  const AppText(
                    text: "Repeat Daily",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.orangeColor,
                  ),
                  const Spacer(),
                  Checkbox(
                      side: const BorderSide(color: AppColor.orangeColor),
                      activeColor: AppColor.orangeColor,
                      value: viewModel.isShowNotification,
                      focusColor: AppColor.orangeColor,
                      onChanged: (v) {
                        viewModel.setShowNotification(v ?? true);
                      }),
                  const AppText(
                    text: "Show Notification",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.orangeColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AppCustomTextField(
                prefix: const Icon(
                  Icons.watch,
                  color: AppColor.orangeColor,
                ),
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (context.mounted) {
                    viewModel.setTime(time ?? TimeOfDay.now(), context);
                  }
                },
                controller: viewModel.taskTimeController,
                readOnly: true,
              ),
              const SizedBox(
                height: 20,
              ),
              viewModel.isTaskAdding
                  ? const MyLoadingButton()
                  : MyButton(
                      title: isEdit == true ? "Edit Task" : "Add Task",
                      margin: const EdgeInsets.only(top: 20),
                      function: () async {
                        // if (formKey.currentState!.validate()) {
                        TaskDataModel model = TaskDataModel(
                            viewModel.taskTileController.text,
                            viewModel.taskDescriptionController.text,
                            0.0,
                            viewModel.taskDate,
                            "Pending",
                            viewModel.isRepeat);
                        bool res = await viewModel.addTask(model);
                        NotificationService.createNotifcation(
                            notificationTitle:
                                viewModel.taskTileController.text,
                            notificationBody:
                                viewModel.taskDescriptionController.text,
                            date: viewModel.taskDate,
                            time: viewModel.taskTime,
                            id: 2,
                            isRepeat: viewModel.isRepeat);
                        if (res) {
                          if (context.mounted) {
                            bottomViewModel.changePage(1);
                          }
                          // }
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
