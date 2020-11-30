import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/views/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ivory Cloud',
      theme: ThemeData(
        //primaryColor: ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}