import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/ui/widgets/custom_field.dart';
import 'package:parkner_mobile_app/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'pay_dialog_model.dart';

class PayDialog extends StackedView<PayDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PayDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PayDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
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
                          "Place reservation",
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
                hintText: "Fill in number of hours",
                controller: viewModel.hoursController,
              ),
              const SizedBox(height: 16),
              PrimaryBtn(
                btnText: "Pay",
                size: const Size(280, 50),
                backgroundColor: const Color(0xff358C7C),
                onPressed: () async {
                  await viewModel.openMope();
                  completer(DialogResponse(confirmed: true));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  PayDialogModel viewModelBuilder(BuildContext context) => PayDialogModel();
}