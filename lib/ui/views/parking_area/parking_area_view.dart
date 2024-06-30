import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Lot id: $lotId")],
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
