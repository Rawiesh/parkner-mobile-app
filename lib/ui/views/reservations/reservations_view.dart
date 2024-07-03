import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'reservations_viewmodel.dart';

class ReservationsView extends StackedView<ReservationsViewModel> {
  const ReservationsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ReservationsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff6bced1),
        flexibleSpace: const SafeArea(
          child: Center(
            child: Text(
              'Reservations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xff06100E),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: viewModel.reservations.length,
        itemBuilder: (context, index) {
          final el = viewModel.reservations[index];
          if (!el.containsKey("lot_name") || !el.containsKey("reserved_spot")) {
            return Container();
          }

          final text = "${el["lot_name"]} - Spot: ${el["reserved_spot"]}";

          return GestureDetector(
            onTap: () => {},
            child: Card(
              elevation: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: const Color(0xffe6f7f7),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff06100E),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: 1,
        showElevation: true,
        onItemSelected: (i) {
          if (i == 0) viewModel.navigateToHome();
        },
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.local_activity),
            title: const Text('Reservations'),
          ),
        ],
      ),
    );
  }

  @override
  ReservationsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReservationsViewModel();

  @override
  void onViewModelReady(ReservationsViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialiseVM();
  }
}
