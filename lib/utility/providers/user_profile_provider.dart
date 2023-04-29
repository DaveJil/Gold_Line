import 'package:flutter/material.dart';

import '../../models/user_profile/user_profile.dart';
import '../services/user_services.dart';

class UserProfileProvider extends ChangeNotifier {
  BuildContext context;
  UserProfileProvider({
    required this.context,
  });
  final UserServices _services = UserServices();

  // load userprofile
  Future<UserProfile> getProfile() async {
    final profile = await _services.getUserProfile(context);
    return profile;
  }
}
