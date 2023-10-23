
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_wala/common/widgets/app_text.dart';
import 'package:task_wala/constant/app_colors.dart';
import 'package:task_wala/database/task_database/task_model.dart';

class TaskTileWidget extends StatelessWidget {
  final Function function;
  const TaskTileWidget({
    super.key,
    required this.data,
    required this.size,
    required this.function,
  });

  final TaskDataModel data;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffeac4d5),
              Color(0xfffbe0e0),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: data.taskName,
              color: AppColor.blackColor,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
            const SizedBox(
              height: 5,
            ),
            AppText(
              text: data.taskDescription,
              color: AppColor.whiteColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              maxLines: 8,
              alignment: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            LinearPercentIndicator(
              animationDuration: 1000,
              animation: true,
              padding: EdgeInsets.zero,
              width: size.width - 100,
              lineHeight: 15.0,
              percent: data.taskCurrentStatus == "Pending" ? .5 : 1,
              barRadius: const Radius.circular(10),
              backgroundColor: AppColor.lightGrayColor,
              progressColor: data.taskCurrentStatus == "Pending"
                  ? AppColor.yellowColor
                  : const Color(0xff7ce9bf),
            ),
          ],
        ),
      ),
    );
  }
}
