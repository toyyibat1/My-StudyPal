import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/services/push_notification_service/push_notification_service.dart';
import 'package:my_study_pal/src/views/screens/school_schedule_screen.dart';
import 'package:my_study_pal/src/views/screens/study_goal_screen.dart';
import 'package:my_study_pal/src/views/screens/task_screen.dart';
import 'package:my_study_pal/src/views/screens/timetable_screen.dart';

class PushNotifications extends PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    _fcm.configure(
//      called when the app is in foreground
        onMessage: (Map<String, dynamic> message) async {
      _shouldNavigate(message);
    },
//        called when the app has been closed completely and it's opened from the push notification
        onLaunch: (Map<String, dynamic> message) async {
      _shouldNavigate(message);
    },
//        called when the app is in  background and it's opened from the notification drawer
        onResume: (Map<String, dynamic> message) async {
      _shouldNavigate(message);
    });
  }

  void _shouldNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    if (view != null) {
      if (view == 'task_screen') {
        Get.to(TaskScreen());
      } else if (view == 'timetable_screen') {
        Get.to(TimetableScreen());
      } else if (view == 'school_schedule') {
        Get.to(SchoolScheduleScreen());
      } else if (view == 'study_goal') {
        Get.to(StudyGoalScreen());
      }
    }
  }
}
