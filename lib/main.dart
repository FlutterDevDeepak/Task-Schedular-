import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_wala/database/task_database/task_model.dart';
import 'package:task_wala/features/task/views/notes/screen/add_edit_notes_screen.dart';
import 'package:task_wala/routes/app_route.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:task_wala/services/notification/notification_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskDataModelAdapter());
  AwesomeNotifications()
      .requestPermissionToSendNotifications()
      .then((_) => NotificationService.initilizeNotification());

      // AwesomeNotifications().cancel(12);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          onGenerateRoute: MyRouter.generateRoute,
          home: AddEditTaskScreen(),
        ),
      ),
    );
  }
}
