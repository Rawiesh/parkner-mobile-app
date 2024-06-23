import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parkner_mobile_app/app/app.bottomsheets.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/ui/common/app_strings.dart';
import 'package:parkner_mobile_app/ui/views/home2/home_viewmodel2.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel2 getModel() => HomeViewModel2();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('incrementCounter -', () {
      test('When called once should return  Counter is: 1', () {
        final model = getModel();
        model.incrementCounter();
        expect(model.counterLabel, 'Counter is: 1');
      });
    });

    group('showBottomSheet -', () {
      test('When called, should show custom bottom sheet using notice variant',
          () {
        final bottomSheetService = getAndRegisterBottomSheetService();

        final model = getModel();
        model.showBottomSheet();
        verify(bottomSheetService.showCustomSheet(
          variant: BottomSheetType.notice,
          title: ksHomeBottomSheetTitle,
          description: ksHomeBottomSheetDescription,
        ));
      });
    });
  });
}
