import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'src/services/service_locator.dart';
import 'src/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();
  // Get.put<AuthController>(AuthController());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Study Pal',
      initialBinding: ServicesBinding(),
      home: SplashScreen(),
      // initialRoute: "/",
      // routes: {
      //   '/': (context) => SplashScreen(),
      //   '/login': (context) => SigninScreen(),
      //   '/signup': (context) => SignupScreen(),
      //   // '/home': (context) => HomeScreen()
      // });
    );
  }
}
