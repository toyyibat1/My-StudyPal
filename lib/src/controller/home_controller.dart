import '../core/notifier.dart';
import '../models/app_user.dart';

class HomeController extends Notifier {
  final AppUser user;
  HomeController({this.user});

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void onTabSelected(int index) {
    _currentPage = index;
    update();
  }
}
