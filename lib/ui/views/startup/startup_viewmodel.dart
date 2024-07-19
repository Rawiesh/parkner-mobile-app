import 'package:parkner_mobile_app/app/app.dialogs.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/app/app.router.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/services/constants_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _constantsService = locator<ConstantsService>();
  final _dialogService = locator<DialogService>();

  Future<void> initialiseVM() async {
    await _constantsService.updateApiUrl();
  }

  void onLoginPressed() async {
    _dialogService.showCustomDialog(variant: DialogType.login);
  }

  void onSignUpPressed() async {
    _dialogService.showCustomDialog(variant: DialogType.signup);
  }

  void onGuestPress() async {
    _authService.clearUser();
    _navigationService.navigateTo(Routes.homeView);
  }
}
