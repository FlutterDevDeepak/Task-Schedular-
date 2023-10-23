import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_wala/common/widgets/app_text.dart';
import 'package:task_wala/common/widgets/my_button.dart';
import 'package:task_wala/constant/app_colors.dart';
import 'package:task_wala/database/task_database/task_model.dart';
import 'package:task_wala/features/task/view_model/task_view_model.dart';
import 'package:task_wala/features/task/views/notes/screen/add_edit_notes_screen.dart';
import 'package:task_wala/features/task/widgets/task_tile_widget.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(taskViewModel);
    final Size size = MediaQuery.sizeOf(context);
    useEffect(() {
      viewModel.selectedDate = DateTime.now();
      viewModel.getTask();
      return;
    }, const []);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: EasyDateTimeLine(
                activeColor: AppColor.whiteColor,
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  viewModel.setSelectedDate(selectedDate);
                },
                headerProps: const EasyHeaderProps(
                  monthPickerType: MonthPickerType.dropDown,
                  selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
                ),
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  inactiveDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grayColor),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.lightpinkColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.lightOrangeColor,
                          AppColor.orangeColor
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const AppText(
              text: "Today's Task",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: viewModel.taskDataList.isEmpty
                  ? Container()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.taskDataList.length,
                      itemBuilder: (context, index) {
                        var reversList =
                            viewModel.taskDataList.reversed.toList();
                        var data = reversList[index];
                        if (data.date.day == viewModel.selectedDate.day) {
                          return TaskTileWidget(
                            data: data,
                            size: size,
                            function: () {
                              showBottomSheet(context, data, viewModel, index);
                            },
                          );
                        }
                        if (data.isRepeat) {
                          return TaskTileWidget(
                            data: data,
                            size: size,
                            function: () {
                              showBottomSheet(context, data, viewModel, index);
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
            )
          ],
        ),
      ),
    );
  }
}

showBottomSheet(BuildContext context, TaskDataModel model,
    TaskViewModel viewModel, int index) {
  return showModalBottomSheet(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 320,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              MyButton(
                color: model.taskCurrentStatus == "Complete"
                    ? AppColor.grayColor
                    : const Color(0xff7ce9bf),
                title: model.taskCurrentStatus == "Complete"
                    ? "Task already completed"
                    : "Mark as Complete",
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                function: model.taskCurrentStatus == "Complete"
                    ? () {
                        Navigator.pop(context);
                      }
                    : () async {
                        TaskDataModel data = TaskDataModel(
                            model.taskName,
                            model.taskDescription,
                            model.completePercentage,
                            model.date,
                            "Complete",
                            model.isRepeat);

                        bool res = await viewModel.editaddTask(index, data);
                        if (res) {
                          await viewModel.getTask();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
              ),
              MyButton(
                color: AppColor.redColor,
                title: "Delete Task",
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                function: () async {
                  bool res = await viewModel.deleteaddTask(index);
                  if (res) {
                    await viewModel.getTask();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              MyButton(
                  color: AppColor.orangeColor,
                  title: "Edit Task",
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddEditTaskScreen(
                                  isEdit: true,
                                  model: model,
                                  index: index,
                                )));
                  }),
              MyButton(
                color: AppColor.brownColor,
                title: "Cancel",
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                function: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      });
}
