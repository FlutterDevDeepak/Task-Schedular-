import 'package:flutter/material.dart';
import 'package:task_wala/common/widgets/app_text.dart';

import '../../constant/app_colors.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Function function;

  const MyButton({
    super.key,
    required this.title,
    this.color = AppColor.orangeColor,
    required this.margin,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        margin: margin,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          color: color,
        ),
        child: AppText(
          text: title,
          color: AppColor.whiteColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MyLoadingButton extends StatelessWidget {
  const MyLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          color: AppColor.orangeColor,
        ),
        child: const CircularProgressIndicator(
          color: AppColor.whiteColor,
        ));
  }
}
