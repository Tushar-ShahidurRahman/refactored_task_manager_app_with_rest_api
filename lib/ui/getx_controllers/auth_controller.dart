import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/main_bottom_nav_bar.dart';

import '../../data/auth_utils.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';

class AuthController extends GetxController {
  bool loginInProgress = false;

  Future<bool> login(String email, String password, [onUnauthorized]) async {
    loginInProgress = true;
    update();
    // setState(() {});
    final result = await NetworkUtils.postMethod(
      Urls.loginUrl,
      body: {
        'email': email,
        'password': password,
      },
      //It's part of UI code. So, does not belong here...
      // onUnAuthorized: () {
      //   Get.snackbar('Login Failed', 'User name or password is incorrect', backgroundColor: Colors.red);
      //   // showSnackBarMessage(
      //     //     context, 'User name or password is incorrect', true);
      // },
    );
    loginInProgress = false;

    if (result != null && result['status'] == 'success') {
      //from the inside of that login method call AuthUtils.saveUser method.
      AuthUtils.saveUserData(
        userEmail: result['data']['email'],
        userFirstName: result['data']['firstName'],
        userLastName: result['data']['lastName'],
        userProfilePic: result['data']['photo'],
        userMobile: result['data']['mobile'],
        userToken: result['token'],
      );
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
