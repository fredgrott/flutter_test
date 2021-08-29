import 'package:flutter_test/flutter_test.dart';
import 'package:expert_test_setup/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
}
