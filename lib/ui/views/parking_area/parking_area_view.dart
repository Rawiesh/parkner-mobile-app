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
}
