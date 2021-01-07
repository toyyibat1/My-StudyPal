import 'package:get/get.dart';

import 'auth_service/auth_service.dart';
import 'auth_service/firebase_auth_service.dart';
import 'data_connection_service/data_connection_checker_service.dart';
import 'data_connection_service/data_connection_service.dart';
import 'database_service/database_service.dart';
import 'database_service/firebase_firestore_service.dart';
import 'push_notification_service/push_notification.dart';
import 'push_notification_service/push_notification_service.dart';
import 'startup_service/get_storage_service.dart';
import 'startup_service/startup_service.dart';

class ServicesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartupService>(() => GetStorageService());
    Get.lazyPut<AuthService>(() => FirebaseAuthService(), fenix: true);
    Get.lazyPut<DatabaseService>(() => FirebaseFirestoreService(), fenix: true);
    Get.lazyPut<DataConnectionService>(() => DataConnectionCheckerService(),
        fenix: true);
    Get.lazyPut<PushNotificationService>(() => PushNotifications(),
        fenix: true);
  }
}
