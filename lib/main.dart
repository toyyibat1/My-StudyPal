import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/views/screens/home_screen.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';
import 'package:my_study_pal/src/views/screens/signup_screen.dart';

import 'src/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  runApp(App());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: mainNavigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'My Study Pal',
        //home: SplashScreen(),
        initialRoute: "/",
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => SigninScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => HomeScreen()
        });
  }
}
