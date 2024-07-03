import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReservationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToHome() {
    _navigationService.navigateToHomeView();
  }
}
