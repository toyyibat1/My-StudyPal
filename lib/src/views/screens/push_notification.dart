//import 'package:firebase_messaging/firebase_messaging.dart';
//
//class PushNotificationsManager {
//  PushNotificationsManager._();
//  factory PushNotificationsManager() => _instance;
//  static final PushNotificationsManager _instance =
//      PushNotificationsManager._();
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  bool _initialized = false;
//
//  Future<void> init() async {
//    if (!_initialized) {
////        for ios request permission
//      _firebaseMessaging.requestNotificationPermissions();
//      _firebaseMessaging.configure();
//
////       for testing purposes print the firebase messaging token
//      String token = await _firebaseMessaging.getToken();
//      print("FirebaseMessaging token: $token");
//
//      _initialized = true;
//    }
//  }
//}
