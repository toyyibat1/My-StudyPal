import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/failure.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  void init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializePlatformSpecifics();
  }

  void initializePlatformSpecifics() {
    var initializationSettingAndroid =
        AndroidInitializationSettings('app_logo');

    initializationSettings =
        InitializationSettings(android: initializationSettingAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) {
      // onclick function(Leads to the Dashboard by default)
      return null;
    });
  }

  void setNotificationOnclick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        onNotificationClick(payload);
      },
    );
  }

  Future<void> showNotification(
      String message, String messageBody, String channelDesc) async {
    try {
      var androidChannelSpecifics = AndroidNotificationDetails(
        'Reminder',
        'Reminder',
        channelDesc,
        largeIcon: DrawableResourceAndroidBitmap('app_logo'),
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        enableLights: true,
        importance: Importance.max,
        enableVibration: true,
        priority: Priority.high,
        playSound: true,
        indeterminate: true,
        autoCancel: true,
        visibility: NotificationVisibility.public,
        styleInformation: DefaultStyleInformation(true, true),
      );
      var platformChannelSpecifics =
          NotificationDetails(android: androidChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        'Hey ' + message + ',',
        messageBody,
        platformChannelSpecifics,
        payload: "Test Payload",
      );
    } on Failure catch (e) {
      print(e.message);
    }
  }

  Future<void> scheduleNotification(int id, String message, String messageBody,
      DateTime notificationDate, String channelDesc) async {
    try {
      var androidChannelSpecifics = AndroidNotificationDetails(
        'MyStudyPadi',
        'Reminder',
        channelDesc,
        largeIcon: DrawableResourceAndroidBitmap('app_logo'),
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        enableLights: true,
        importance: Importance.max,
        enableVibration: true,
        priority: Priority.high,
        playSound: true,
        indeterminate: true,
        autoCancel: true,
        visibility: NotificationVisibility.public,
        styleInformation: DefaultStyleInformation(true, true),
      );
      var platformChannelSpecifics =
          NotificationDetails(android: androidChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(id, message.toUpperCase(),
          messageBody, notificationDate, platformChannelSpecifics,
          payload: "Payload schedule");
    } on Failure catch (e) {
      throw Failure(e.message);
    }
  }

  // Weekly notification for time table
  Future<void> weeklyNotification(int id, String message, String messageBody,
      Day notificationDay, Time notificationTime, String channelDesc) async {
    try {
      var androidChannelSpecifics = AndroidNotificationDetails(
        'MyStudyPadi',
        'Reminder',
        channelDesc,
        largeIcon: DrawableResourceAndroidBitmap('app_logo'),
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        importance: Importance.max,
        enableVibration: true,
        priority: Priority.high,
        playSound: true,
        indeterminate: true,
        autoCancel: true,
        visibility: NotificationVisibility.public,
        styleInformation: DefaultStyleInformation(true, true),
      );
      var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        message.toUpperCase(),
        messageBody,
        notificationDay,
        notificationTime,
        platformChannelSpecifics,
        payload: "Payload schedule",
      );
    } on Failure catch (e) {
      throw Failure(e.message);
    }
  }

  // Method to cancel specific notification
  Future<void> cancelNotification(
    int id,
  ) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();
