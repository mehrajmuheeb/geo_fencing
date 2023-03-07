import 'package:base_flutter/helpers/mixin/auth_mixin.dart';

class AppState with AuthMixin {

  //Checks the Login/OnBoarded status of the User
  Future<List<bool>> checkForLoginCredentials() async {
    String? authToken = null;

    var isLoggedIn = authToken != null && authToken.isNotEmpty;

    return [
      isLoggedIn
    ];
  }
}