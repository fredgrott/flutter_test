// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:how_open_drawer/main.dart';

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

    testWidgets('How do I open a Drawer?', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final Finder drawerFinder = find.byType(Drawer);

      expect(drawerFinder, findsNothing);

      //
      // Method a)
      //

      // open Drawer by tapping the menu icon in the Appbar
      final Finder menuIconFinder = find.byIcon(Icons.menu);
      await tester.tap(menuIconFinder);
      await tester.pumpAndSettle();

      // confirm that the Drawer is open
      expect(drawerFinder, findsOneWidget);

      // close Drawer
      Navigator.of(tester.element(drawerFinder)).pop();
      await tester.pumpAndSettle();
      expect(drawerFinder, findsNothing);

      //
      // Method b)
      //

      // open Drawer by using scaffoldKey
      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      // confirm that the Drawer is open
      expect(drawerFinder, findsOneWidget);

      // close Drawer
      Navigator.of(tester.element(drawerFinder)).pop();
      await tester.pumpAndSettle();
      expect(drawerFinder, findsNothing);

      //
      // Method c)
      //

      // open Drawer by using a BuildContext and finding a Scaffold with Scaffold.of
      final Finder bodyFinder = find.byType(Body);
      Scaffold.of(tester.element(bodyFinder)).openDrawer();
      await tester.pumpAndSettle();

      // confirm that the Drawer is open
      expect(drawerFinder, findsOneWidget);

      // close Drawer
      Navigator.of(tester.element(drawerFinder)).pop();
      await tester.pumpAndSettle();
      expect(drawerFinder, findsNothing);

      //
      // Method d)
      //

      // open Drawer by swiping from the left edge
      await tester.dragFrom(const Offset(0, 100), const Offset(300, 100));
      await tester.pumpAndSettle();

      // confirm that the Drawer is open
      expect(drawerFinder, findsOneWidget);

      // close Drawer
      Navigator.of(tester.element(drawerFinder)).pop();
      await tester.pumpAndSettle();
      expect(drawerFinder, findsNothing);
    });


  });

  
}
