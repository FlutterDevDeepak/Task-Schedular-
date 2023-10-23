import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_wala/common/widgets/app_text.dart';
import 'package:task_wala/constant/app_colors.dart';
import 'package:task_wala/constant/routes_name.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, RouteName.bottomNav);
        });
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/svg/splash_task.svg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: AppColor.orangeColor,
            ),
            child: const AppText(
              text: '''Let's add your task''',
              color: AppColor.whiteColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
