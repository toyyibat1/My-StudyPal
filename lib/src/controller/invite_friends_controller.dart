import 'dart:io';

import 'package:get/get.dart';
import 'package:my_study_pal/src/core/failure.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/core/validation_mixin.dart';
import 'package:my_study_pal/src/views/screens/invites_success_screen.dart';
import 'package:share/share.dart';

class InviteFriendsController extends Notifier with ValidationMixin {
  @override
  void onReady() {
    Get.to(InviteSuccessScreen());
    super.onReady();
  }

  Future<Null> urlFileShare() async {
    setState(NotifierState.isIdle);
    try {
      if (Platform.isAndroid) {
        var url = 'Hey padi, download  Mystdypadi App :\nhttps://studypadi.com';
        await Share.share(url, subject: 'App Download Share');
      } else {
        var url = 'https://studypadi.com';
        await Share.share(url, subject: 'URL File Share');
      }
    } catch (e) {
      throw Failure("Unable to share link");
    }
  }
}
