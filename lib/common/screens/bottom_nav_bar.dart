import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_wala/common/view_model/bottom_nav_vm.dart';
import 'package:task_wala/constant/app_assets.dart';

class BottomNavbar extends HookConsumerWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bottomNavVm);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        viewModel.changePage(0);
      });

      return;
    }, const []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          viewModel.changePage(1);
        },
        child: Image.asset(
          AppAssets.addIcon,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      body: viewModel.screens[viewModel.selectedindex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onTap: (index) {
            viewModel.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.taskIcon,
                  height: 30,
                  width: 35,
                  fit: BoxFit.cover,
                ),
                label: ''),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.transparent,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Image.asset(
                  AppAssets.profileIcon,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
                label: ''),
          ]),
    );
  }
}
