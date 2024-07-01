import 'package:parkner_mobile_app/app/app.dialogs.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  void onLoginPressed() async {
    _dialogService.showCustomDialog(variant: DialogType.login);
  }

  void onGuestPress() async {
    _navigationService.navigateTo(Routes.homeView);
  }
}
