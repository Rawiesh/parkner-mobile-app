import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/ui/widgets/area_card.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final searchController = TextEditingController();
  final List<Widget> areasSection = [];
  dynamic areas = [];
  Timer? _timer;

  Future<void> fetchAllAreas() async {
    final response =
        await http.get(Uri.parse('https://parkner.vercel.app/api/lots'));
    if (response.statusCode == 200) {
      if (response.body == jsonEncode(areas)) return;
      areas = jsonDecode(response.body);
      createAreaWidgets();
    }
  }

  void startFetchingAreas() {
    fetchAllAreas();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchAllAreas();
    });
  }

  void stopFetchingAreas() {
    _timer?.cancel();
  }

  void onSearchSubmitted(String value) {}

  void createAreaWidgets() {
    areasSection.clear();
    for (var area in areas) {
      areasSection.add(AreaCard(
        imgUrl: area["img_url"] ?? "https://picsum.photos/250?image=9",
        name: area["name"],
        location: area["location"] ?? "Location",
        distance: area["distance"] ?? "Distance",
        price: area["reservation_price"]?.toString(),
      ));
      areasSection.add(const SizedBox(height: 16));
    }
    notifyListeners();
  }

  @override
  void dispose() {
    stopFetchingAreas();
    searchController.dispose();
    super.dispose();
  }
}
