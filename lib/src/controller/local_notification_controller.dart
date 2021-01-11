import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_study_pal/src/core/failure.dart';

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
        AndroidInitializationSettings('app_icon');

    initializationSettings =
        InitializationSettings(android: initializationSettingAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) {},
    );
  }

  void setNotificationOnclick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showNotification(
      String message, String messageBody, String channelDesc) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'Reminder',
      'Reminder',
      channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
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
  }

  Future<void> scheduleNotification(
    String message,
    String messageBody,
    DateTime notificationDate,
    String channelDesc,
  ) async {
    try {
      var androidChannelSpecifics = AndroidNotificationDetails(
        'MyStudyPadi',
        'Reminder',
        channelDesc,
        largeIcon: DrawableResourceAndroidBitmap('app_icon'),
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        enableLights: true,
        importance: Importance.max,
        fullScreenIntent: true,
        enableVibration: true,
        priority: Priority.high,
        playSound: true,
        usesChronometer: true,
        indeterminate: true,
        autoCancel: false,
        visibility: NotificationVisibility.public,
        styleInformation: DefaultStyleInformation(true, true),
      );

      var platformChannelSpecifics =
          NotificationDetails(android: androidChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(
        0,
        message.toUpperCase(),
        messageBody,
        notificationDate,
        platformChannelSpecifics,
        payload: "Payload schedule",
      );
    } on Failure catch (e) {
      throw Failure(e.message);
    }
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();
