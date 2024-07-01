import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/ui/views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginDialogModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String formMsg = "";

  Future<bool> onLoginPressed() async {
    formMsg = "";
    notifyListeners();
    final msg = await _authService.loginUser(
      username: usernameController.text,
      password: passwordController.text,
    );
    if (msg != null) {
      formMsg = msg;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void continueToHome() {
    _navigationService.navigateToView(const HomeView());
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
