import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/ui/views/parking_area/parking_area_view.dart';
import 'package:parkner_mobile_app/ui/widgets/area_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final searchController = TextEditingController();
  final List<Widget> areasSection = [];
  dynamic areas = [];
  Timer? _timer;
  Map? user;

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

  void initialiseVM() {
    user = _authService.user;
    notifyListeners();
    fetchAllAreas();
    // TODO: Reduce to 500ms before production build
    _timer = Timer.periodic(const Duration(days: 1), (timer) {
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
        onTap: () {
          _navigationService.navigateToView(
            ParkingAreaView(lotId: area["lot_id"]),
          );
        },
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
