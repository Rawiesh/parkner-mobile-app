import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/ui/widgets/parking_grid.dart';
import 'package:parkner_mobile_app/ui/widgets/primary_button.dart';
import 'package:stacked/stacked.dart';

import 'parking_area_viewmodel.dart';

class ParkingAreaView extends StackedView<ParkingAreaViewModel> {
  final String? lotId;
  const ParkingAreaView({Key? key, this.lotId}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ParkingAreaViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(viewModel.lotData?["name"] ?? "Parking Lot"),
        backgroundColor: const Color(0xff6bced1),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Parking Spots",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff06100E),
                  ),
                ),
                Text(
                  "${viewModel.availableSpots} spots available",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff358C7C),
                  ),
                ),
                const SizedBox(height: 16),
                ParkingGrid(
                  selectedSpot: viewModel.selectedSpot,
                  setSelectedSpot: viewModel.setSelectedSpot,
                  lotData: viewModel.lotData,
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "SRD ${viewModel.lotData?["reservation_price"]?.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff38403E),
                      ),
                    ),
                    const Text(
                      "per hour",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff38403E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                PrimaryBtn(
                  btnText: "Reserve",
                  size: const Size(250, 50),
                  onPressed: viewModel.onReservePressed,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  ParkingAreaViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ParkingAreaViewModel();

  @override
  void onViewModelReady(ParkingAreaViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialiseVM(receivedLotId: lotId);
  }
}
