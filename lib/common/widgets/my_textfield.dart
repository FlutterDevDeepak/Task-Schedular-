import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';

class AppCustomTextField extends StatelessWidget {
  final String hint;
  final Function? onTap;
  final TextEditingController controller;
  final int maxLines;
  final bool readOnly;
  final Widget? prefix;
  const AppCustomTextField(
      {super.key,
      this.hint = "Enter your task title",
      required this.controller,
      this.maxLines = 1,
      this.onTap,
      this.readOnly = false,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        onTap!();
      },
      readOnly: readOnly,
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: prefix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColor.orangeColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColor.orangeColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColor.orangeColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColor.lighRedColor),
          ),
          hintText: hint),
      validator: (v) {
        return v!.isEmpty ? "Required" : null;
      },
    );
  }
}
