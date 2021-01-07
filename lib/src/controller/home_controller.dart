import 'package:firebase_auth/firebase_auth.dart';

import '../core/notifier.dart';
import '../models/app_user.dart';

class HomeController extends Notifier {
 // final User user1;
  final AppUser user;
  HomeController({this.user});

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void onTabSelected(int index) {
    _currentPage = index;
    update();
  }
}
