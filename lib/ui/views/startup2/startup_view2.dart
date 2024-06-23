import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:parkner_mobile_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView2 extends StackedView<StartupViewModel2> {
  const StartupView2({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel2 viewModel,
    Widget? child,
  ) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'STACKED',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Loading ...', style: TextStyle(fontSize: 16)),
                horizontalSpaceSmall,
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 6,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel2 viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel2();

  @override
  void onViewModelReady(StartupViewModel2 viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
