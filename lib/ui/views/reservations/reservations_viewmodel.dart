import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/app/app.router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReservationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  SharedPreferences? prefs;
  List<String> reservationIds = [];
  List<dynamic> reservations = [];

  Future<void> initialiseVM() async {
    prefs = await SharedPreferences.getInstance();
    reservationIds = prefs?.getStringList('reservations') ?? [];
    for (var id in reservationIds) {
      await updateReservationsList(id);
    }
    notifyListeners();
  }

  Future<void> updateReservationsList(String id) async {
    final response = await http
        .get(Uri.parse("https://parkner.vercel.app/api/lots/reservations/$id"));
    if (response.statusCode == 200) {
      var reservationData = jsonDecode(response.body);
      reservations.add(reservationData);
    }
  }

  void navigateToHome() {
    _navigationService.navigateToHomeView();
  }
}
