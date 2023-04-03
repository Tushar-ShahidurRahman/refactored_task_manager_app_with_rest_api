import 'package:flutter/material.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/getx_controllers/auth_controller.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/main_bottom_nav_bar.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/signUp_screen.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/screens/verify_with_email_screen.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/utils/snackbar_message.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/utils/text_style.dart';
import 'package:refactored_task_manager_app_with_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_button.dart';
import '../widgets/app_text_field_widget.dart';

// import '../getx_controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailETController = TextEditingController();

  final TextEditingController _passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get started with',
                    style: screenTitleTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFieldWidget(
                    hintText: 'Email',
                    controller: _emailETController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                    hintText: 'Password',
                    controller: _passwordETController,
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) &&
                          ((value?.length ?? 0) < 6)) {
                        return 'Enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  GetBuilder<AuthController>(
                    builder: (authController) {
                      if (authController.loginInProgress) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.green));
                      }
                      return AppElevatedButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            //call the log in method from here.
                            final result = await authController.login(
                              _emailETController.text.trim(),
                              _passwordETController.text,
                            );
                            if (result) {
                              Get.offAll(() => const MainBottomNavBar());
                            } else {
                              Get.showSnackbar(const GetSnackBar(
                                title: 'Log in failed. Try again',
                              ));
                            }
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_rounded),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(const VerifyWithEmailScreen());
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      AppTextButton(
                        onTap: () {
                          Get.to(const SignUpScreen());
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
