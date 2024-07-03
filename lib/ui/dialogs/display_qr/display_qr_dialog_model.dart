import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class DisplayQrDialogModel extends BaseViewModel {
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
      Uri.parse('https://parkner.vercel.app/api/lots/reservations/delete'),
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
      Uri.parse('https://parkner.vercel.app/api/lot/${newLotData["lot_id"]}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newLotData),
    );
  }

  Future<void> fetchLotData(String lotId) async {
    final response =
        await http.get(Uri.parse('https://parkner.vercel.app/api/lot/$lotId'));
    if (response.statusCode == 200) {
      lotData = jsonDecode(response.body);
    }
    notifyListeners();
  }
}
