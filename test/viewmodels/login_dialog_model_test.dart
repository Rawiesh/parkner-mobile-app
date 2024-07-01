import 'package:flutter_test/flutter_test.dart';
import 'package:parkner_mobile_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LoginDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
