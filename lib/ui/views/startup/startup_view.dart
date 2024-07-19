import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/ui/widgets/guest_button.dart';
import 'package:parkner_mobile_app/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(181, 230, 232, 1),
              Color.fromRGBO(157, 239, 242, 1),
              Color.fromRGBO(9, 172, 178, 0.8)
            ],
            stops: [0, 0.65, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
              width: 250,
            ),
            const SizedBox(height: 24),
            const Text(
              "All parking spots in one place",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff06100E),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Never worry about parking again",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff38403E),
              ),
            ),
            const SizedBox(height: 32),
            PrimaryBtn(
              btnText: "Login",
              size: const Size(250, 50),
              backgroundColor: const Color(0xff358C7C),
              onPressed: viewModel.onLoginPressed,
            ),
            const SizedBox(height: 16),
            PrimaryBtn(
              btnText: "Sign up",
              size: const Size(250, 50),
              backgroundColor: const Color(0xffFF6961),
              onPressed: viewModel.onSignUpPressed,
            ),
            const SizedBox(height: 16),
            GuestButton(onPress: viewModel.onGuestPress),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialiseVM();
  }
}
