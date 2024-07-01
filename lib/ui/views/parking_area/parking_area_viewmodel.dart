import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class ParkingAreaViewModel extends BaseViewModel {
  String? lotId;
  dynamic lotData;
  Timer? _timer;
  String selectedSpot = "";
  int availableSpots = 6;

  void initialiseVM({required String? receivedLotId}) {
    lotId = receivedLotId;
    startFetchingLotData();
  }

  void setSelectedSpot(String value) {
    if (lotData?["reservable"] == true) {
      selectedSpot = value;
      notifyListeners();
    }
  }

  void onReservePressed() {}

  Future<void> fetchLotData() async {
    final response =
        await http.get(Uri.parse('https://parkner.vercel.app/api/lot/$lotId'));
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
    _timer = Timer.periodic(const Duration(days: 1), (timer) {
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
