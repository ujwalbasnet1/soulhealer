import 'package:flutter/material.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/data_sources/auth/models/login_response.dart';

import 'hero/message_hero_view.dart';
import 'user/message_user_view.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (UserDataService().user.userType == UserType.HERO)
          ? MessageHeroView()
          : MessageUserView(),
    );
  }
}
