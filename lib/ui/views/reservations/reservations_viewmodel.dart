import 'dart:developer';

import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReservationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  SharedPreferences? prefs;
  List<String> reservations = [];

  Future<void> initialiseVM() async {
    prefs = await SharedPreferences.getInstance();
    reservations = prefs?.getStringList('reservations') ?? [];
    inspect(reservations);
  }

  void navigateToHome() {
    _navigationService.navigateToHomeView();
  }
}
