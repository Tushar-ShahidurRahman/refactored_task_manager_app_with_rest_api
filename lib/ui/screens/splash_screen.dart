import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:refactored_task_manager_app_with_rest_api/data/auth_utils.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/login_screen.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/home_screen.dart';

import '../widgets/screen_background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      checkUserAuthState();
    });

  }

  checkUserAuthState() async {
    final loggedIn = await AuthUtils.checkLogInState();
    if (loggedIn) {
      //updated with get
      Get.offAll(() => const HomeScreen());
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const HomeScreen(),
      //     ),
      //     (route) => false);
    } else {
      //updated with get
      //  it had same lines of code as the If part, now it's slimmer.
      Get.offAll(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/flask-chemistry.svg',
            width: 130,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
