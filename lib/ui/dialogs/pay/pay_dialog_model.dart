import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class PayDialogModel extends BaseViewModel with WidgetsBindingObserver {
  final hoursController = TextEditingController();

  Future<void> openMope() async {
    String url = "https://parkner.vercel.app/payment-example";
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
