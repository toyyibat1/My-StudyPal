import 'dart:io';

import 'package:my_study_pal/src/core/failure.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/core/validation_mixin.dart';
import 'package:share/share.dart';

class InviteFriendsController extends Notifier with ValidationMixin {
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
      throw Failure(e.message);
    }
  }
}
