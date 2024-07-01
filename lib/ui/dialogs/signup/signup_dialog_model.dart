import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupDialogModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String formMsg = "";

  Future<bool> onSignUpPressed() async {
    formMsg = "";
    notifyListeners();
    final msg = await _authService.signUpUser(
      username: usernameController.text,
      email: usernameController.text,
      password: passwordController.text,
    );
    if (msg != null) {
      formMsg = msg;
      notifyListeners();
      return false;
    } else {
      await _authService.loginUser(
        username: usernameController.text,
        password: passwordController.text,
      );
      _navigationService.clearStackAndShowView(const HomeView());
      return true;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
