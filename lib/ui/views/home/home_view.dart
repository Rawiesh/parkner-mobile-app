import 'package:flutter/material.dart';
import 'package:parkner_mobile_app/ui/widgets/search_input.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: const BoxDecoration(
              color: Color(0xff6bced1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(36, 16),
                bottomRight: Radius.elliptical(36, 16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello Guest!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff06100E),
                  ),
                ),
                const Text(
                  "Let's find you the best parking space",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff38403E),
                  ),
                ),
                const SizedBox(height: 12),
                SearchInput(
                  controller: viewModel.searchController,
                  onSubmit: viewModel.onSearchSubmitted,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Total: ${viewModel.areas.length} Parking Area's",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff06100E),
            ),
          ),
          const SizedBox(height: 16),
          ...viewModel.areasSection,
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.startFetchingAreas();
  }
}
