import 'package:parkner_mobile_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:parkner_mobile_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:parkner_mobile_app/ui/views/home/home_view.dart';
import 'package:parkner_mobile_app/ui/views/home2/home_view2.dart';
import 'package:parkner_mobile_app/ui/views/startup/startup_view.dart';
import 'package:parkner_mobile_app/ui/views/startup2/startup_view2.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:parkner_mobile_app/ui/views/parking_area/parking_area_view.dart';
import 'package:parkner_mobile_app/services/auth_service.dart';
import 'package:parkner_mobile_app/ui/dialogs/login/login_dialog.dart';
import 'package:parkner_mobile_app/ui/dialogs/signup/signup_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView2),
    MaterialRoute(page: StartupView2),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ParkingAreaView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: LoginDialog),
    StackedDialog(classType: SignupDialog),
// @stacked-dialog
  ],
)
class App {}
