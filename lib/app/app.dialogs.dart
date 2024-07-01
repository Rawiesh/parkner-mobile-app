// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/login/login_dialog.dart';
import '../ui/dialogs/signup/signup_dialog.dart';

enum DialogType {
  infoAlert,
  login,
  signup,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.login: (context, request, completer) =>
        LoginDialog(request: request, completer: completer),
    DialogType.signup: (context, request, completer) =>
        SignupDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
