import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/ui/widgets/custom_field.dart';
import 'package:parkner_mobile_app/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'signup_dialog_model.dart';

class SignupDialog extends StackedView<SignupDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SignupDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up to continue",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              CustomField(
                hintText: "Username",
                controller: viewModel.usernameController,
              ),
              const SizedBox(height: 16),
              CustomField(
                hintText: "Email",
                controller: viewModel.emailController,
              ),
              const SizedBox(height: 16),
              CustomField(
                hintText: "Password",
                controller: viewModel.passwordController,
                isObscureText: true,
              ),
              const SizedBox(height: 12),
              viewModel.formMsg.isNotEmpty
                  ? Text(
                      viewModel.formMsg,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 12),
              PrimaryBtn(
                btnText: "Sign up",
                size: const Size(280, 50),
                backgroundColor: const Color(0xff358C7C),
                onPressed: () async {
                  final res = await viewModel.onSignUpPressed();
                  if (res == false) return;
                  completer(DialogResponse(confirmed: true));
                  viewModel.continueToHome();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  SignupDialogModel viewModelBuilder(BuildContext context) =>
      SignupDialogModel();
}
