import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/constants_service.dart';
import 'package:parkner_mobile_app/ui/widgets/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'display_qr_dialog_model.dart';

class DisplayQrDialog extends StackedView<DisplayQrDialogModel> {
  final _constantsService = locator<ConstantsService>();

  final DialogRequest request;
  final Function(DialogResponse) completer;

  DisplayQrDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DisplayQrDialogModel viewModel,
    Widget? child,
  ) {
    final reservationData = request.data["reservation_data"];
    final qrUrl =
        '${_constantsService.apiUrl}/lots/reservations/${reservationData["reservation_id"]}';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.data["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            QrImageView(
              data: qrUrl,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimaryBtn(
                  btnText: "Cancel",
                  size: const Size(124, 50),
                  backgroundColor: const Color(0xffFF6961),
                  onPressed: () async {
                    await viewModel.onDeleteReservationPress(reservationData);
                    completer(DialogResponse(confirmed: true));
                  },
                ),
                PrimaryBtn(
                  btnText: "Close",
                  size: const Size(124, 50),
                  backgroundColor: const Color(0xff358C7C),
                  onPressed: () {
                    completer(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  DisplayQrDialogModel viewModelBuilder(BuildContext context) =>
      DisplayQrDialogModel();

  @override
  void onViewModelReady(DisplayQrDialogModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialiseVM();
  }
}
