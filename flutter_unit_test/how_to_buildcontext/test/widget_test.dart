// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:how_to_buildcontext/main.dart';

// ignore: unused_element
const _deskTopSize = Size(800, 1280); // physical pixels

void main() {
  // Make good use of [setUpAll], [setUp], [tearDownAll], and [tearDown]
  // to avoid repetitive code. Dont Repeat Yourself.
  // Remember this runs once before ALL tests or groups
  // Mocks set ups go here instead of in the group so applied to all groups of
  // tests.
  // ignore: no-empty-block
  setUpAll(() async {});

  // Remember this runs before EACH test or group
  setUp(() async {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized()
            as TestWidgetsFlutterBinding;

    // You can reset it to something else within a test
    // only on unit tests as in acceptance testing it would
    // be actual device target screen size
    binding.window.physicalSizeTestValue = _deskTopSize;
  });

  // Remember this runs once after ALL tests or groups
  // ignore: no-empty-block
  tearDownAll(() async {});

  // Remember this runs after EACH test or group
  // ignore: no-empty-block
  tearDown(() async {
    // Code that clears caches can go here
  });

  group('Home Page tests', () {
    // ignore: no-empty-block
    setUpAll(() async {});

    // ignore: no-empty-block
    setUp(() async {});

    // ignore: no-empty-block
    tearDownAll(() async {});

    // ignore: no-empty-block
    tearDown(() async {});

    testWidgets('app has title in appbar', (WidgetTester widgetTester) async {
      const testKey = Key('AppbarTitle');

      await widgetTester.pumpWidget(const MyApp());

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets("What if I need a build context?", (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      final Finder page1Finder = find.byType(Page1);
      final Finder page2Finder = find.byType(Page2);

      // Since the initial route was for /page1
      // we expect to see a [Page1] widget and not a [Page2] widget
      expect(page1Finder, findsOneWidget);
      expect(page2Finder, findsNothing);

      //
      // Method a)
      //

      // get [BuildContext] from an element
      final BuildContext page1BuildContext = tester.element(page1Finder);

      // find the closest [Navigator] (which is made available because of [MaterialApp])
      // and pushNamed to /page2
      Navigator.of(page1BuildContext).pushNamed("/page2");

      // Note, since we are using a [MaterialApp] and its named routes use the [MaterialPageRoute],
      // there is a transition of 300 ms
      // https://github.com/flutter/flutter/blob/e58dc16d7bec7199190f1408667e24e38328cc3b/packages/flutter/lib/src/material/page.dart#L61
      // ... so we will need to pump until that transition has settled
      await tester.pumpAndSettle();

      // We now expect to be on [Page2]
      expect(page1Finder, findsNothing);
      expect(page2Finder, findsOneWidget);

      //
      // Method b)
      //

      // get [BuildContext] from a [GlobalKey]
      final BuildContext? page2BuildContext = page2ScaffoldKey.currentContext;

      // Let's navigate back to [Page1]
      Navigator.of(page2BuildContext!).pushNamed("/page1");
      await tester.pumpAndSettle();

      // We now expect to be on [Page1] again
      expect(page1Finder, findsOneWidget);
      expect(page2Finder, findsNothing);
    });

  });

  
}
