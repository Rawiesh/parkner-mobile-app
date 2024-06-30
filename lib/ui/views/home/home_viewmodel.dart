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
      areas = jsonDecode(response.body);
      areas = searchAreas(areas, searchController.text);
      createAreaWidgets();
    }
  }

  List searchAreas(List areas, String query) {
    if (query.isEmpty) return areas;

    final lowerCaseQuery = query.toLowerCase();
    return areas.where((area) {
      final name = area["name"]?.toString().toLowerCase() ?? '';
      final address = area["address"]?.toString().toLowerCase() ?? '';
      return name.contains(lowerCaseQuery) || address.contains(lowerCaseQuery);
    }).toList();
  }

  void startFetchingAreas() {
    fetchAllAreas();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
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
        address: area["address"] ?? "Address",
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
