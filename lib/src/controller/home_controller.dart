import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:my_study_pal/src/models/app_user.dart';

class HomeController extends GetxController {
  final AppUser user;
  HomeController({this.user});

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void onTabSelected(int index) {
    _currentPage = index;
    update();
  }
}
