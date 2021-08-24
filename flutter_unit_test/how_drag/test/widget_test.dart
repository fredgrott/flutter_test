// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:how_drag/main.dart';

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

    testWidgets('app has title in appbar', (WidgetTester widgetTester) async {
      const testKey = Key('AppbarTitle');

      await widgetTester.pumpWidget(const MyApp());

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets("How do I drag something?", (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final Finder draggableFinder = find.text("Draggable");
      final Finder dragTargetFinder = find.text("Drag Target");

      expect(draggableFinder, findsOneWidget);
      expect(dragTargetFinder, findsOneWidget);

      await tester.drag(draggableFinder, const Offset(0, 100));
      await tester.pump();

      expect(dragTargetFinder, findsOneWidget);

      final Finder successfulDragFinder = find.text("Successful drag!");
      expect(successfulDragFinder, findsOneWidget);
    });


  });

  
}
