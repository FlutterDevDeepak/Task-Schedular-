import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static initilizeNotification() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel 1',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              soundSource: 'resource://raw/alram',
              playSound: true,
              ledColor: Colors.white)
        ],
        debug: true);
  }

  static createNotifcation(
      {required String notificationTitle,
      required String notificationBody,
      required DateTime date,
      required TimeOfDay time,
      bool isRepeat = false,
      required int id}) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel 1',
            actionType: ActionType.Default,
            title: notificationTitle,
            body: notificationBody,
            wakeUpScreen: true),
        schedule: NotificationCalendar(
          year: date.year,
          month: date.month,
          day: date.day,
          hour: time.hour,
          minute: time.minute,
          second: 0,
          millisecond: 0,
          repeats: isRepeat,
        ));
  }
}
