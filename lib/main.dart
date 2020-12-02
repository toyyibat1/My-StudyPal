import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'My Study Pal',
      home: SplashScreen(),
    );
  }
}
