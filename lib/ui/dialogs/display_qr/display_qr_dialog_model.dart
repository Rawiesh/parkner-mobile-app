import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/constants_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class DisplayQrDialogModel extends BaseViewModel {
  final _constantsService = locator<ConstantsService>();
  SharedPreferences? prefs;
  dynamic lotData;

  Future<void> initialiseVM() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> onDeleteReservationPress(
    Map reservationData,
  ) async {
    final spot = reservationData["reserved_spot"];
    await http.post(
      Uri.parse('${_constantsService.apiUrl}/lots/reservations/delete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"id": reservationData["reservation_id"]}),
    );

    // Remove from storage
    final List<String> reservations =
        prefs?.getStringList('reservations') ?? [];
    reservations.remove(reservationData["reservation_id"]);
    await prefs?.setStringList('reservations', reservations);

    await fetchLotData(reservationData["lot_id"]);

    // Create a copy with new lot data
    var newLotData = Map.from(lotData);
    if (newLotData["spots"] != null && newLotData["spots"][spot] != null) {
      newLotData["spots"][spot]["reserved"] = false;
    }

    // Post updated lot data
    await http.post(
      Uri.parse('${_constantsService.apiUrl}/lot/${newLotData["lot_id"]}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newLotData),
    );
  }

  Future<void> fetchLotData(String lotId) async {
    final response =
        await http.get(Uri.parse('${_constantsService.apiUrl}/lot/$lotId'));
    if (response.statusCode == 200) {
      lotData = jsonDecode(response.body);
    }
    notifyListeners();
  }
}
