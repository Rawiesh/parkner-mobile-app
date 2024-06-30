import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';

class ParkingAreaViewModel extends BaseViewModel {
  String? lotId;
  dynamic lotData;
  Timer? _timer;

  void initialiseVM({required String? receivedLotId}) {
    lotId = receivedLotId;
    startFetchingLotData();
  }

  Future<void> fetchLotData() async {
    final response =
        await http.get(Uri.parse('https://parkner.vercel.app/api/lot/$lotId'));
    if (response.statusCode == 200) {
      lotData = jsonDecode(response.body);
      inspect(lotData);
    }
  }

  void startFetchingLotData() {
    fetchLotData();
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
