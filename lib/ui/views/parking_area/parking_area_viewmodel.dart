import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/app/app.dialogs.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/services/constants_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ParkingAreaViewModel extends BaseViewModel {
  final _constantsService = locator<ConstantsService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthService>();
  SharedPreferences? prefs;
  String? lotId;
  dynamic lotData;
  Timer? _timer;
  String selectedSpot = "";
  int availableSpots = 6;
  Map? user;

  Future<void> initialiseVM({required String? receivedLotId}) async {
    lotId = receivedLotId;
    user = _authService.user;
    startFetchingLotData();
    prefs = await SharedPreferences.getInstance();
  }

  void setSelectedSpot(String value) {
    if (user == null) return;
    if (lotData?["reservable"] == true) {
      selectedSpot = value;
      notifyListeners();
    }
  }

  Future<void> selectHours() async {
    await _dialogService.showCustomDialog(variant: DialogType.pay);
    await placeReservation();
  }

  Future<void> placeReservation() async {
    await fetchLotData();

    // Create a copy with new lot data
    var newLotData = Map.from(lotData);
    if (newLotData["spots"] != null &&
        newLotData["spots"][selectedSpot] != null) {
      newLotData["spots"][selectedSpot]["reserved"] = true;
    }

    // Post updated lot data
    await http.post(
      Uri.parse('${_constantsService.apiUrl}/lot/${newLotData["lot_id"]}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newLotData),
    );

    // Create a reservation
    final reservationResponse = await http.post(
      Uri.parse('${_constantsService.apiUrl}/lots/reservations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "lot_id": newLotData["lot_id"],
        "lot_name": newLotData["name"],
        "lot_address": newLotData["address"],
        "reserved_spot": selectedSpot,
        "username": user?["username"],
        "user_email": user?["email"],
      }),
    );

    if (reservationResponse.statusCode == 200) {
      var data = jsonDecode(reservationResponse.body);
      String reservationId = data["reservation_id"];

      // Add reservation id to shared preferences
      final List<String> reservations =
          prefs?.getStringList('reservations') ?? [];
      reservations.add(reservationId);
      await prefs?.setStringList('reservations', reservations);
    }

    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      content: Text("Successfully placed reservation"),
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      duration: Duration(seconds: 1),
    ));
    _navigationService.back();
  }

  Future<void> fetchLotData() async {
    final response =
        await http.get(Uri.parse('${_constantsService.apiUrl}/lot/$lotId'));
    if (response.statusCode == 200) {
      lotData = jsonDecode(response.body);
    }

    availableSpots = 0;

    lotData["spots"].forEach((key, spot) {
      if (spot["reserved"] == false && spot["occupied"] == false) {
        availableSpots++;
      }
    });

    notifyListeners();
  }

  void startFetchingLotData() {
    fetchLotData();
    // TODO: Reduce to 500ms before production build
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      fetchLotData();
    });
  }

  void stopFetchingLotData() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopFetchingLotData();
    super.dispose();
  }
}
