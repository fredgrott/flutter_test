// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:how_to_keyboard_action/main.dart';

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

    testWidgets("How do I send a keyboard event?", (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // First, let's confirm we have two TextFields on the page
      final Finder firstNameFinder = find.byType(TextField).at(0);
      final Finder lastNameFinder = find.byType(TextField).at(1);

      expect(firstNameFinder, findsOneWidget);
      expect(lastNameFinder, findsOneWidget);

      // Next, let's enter our first name
      await tester.showKeyboard(firstNameFinder);
      tester.testTextInput.enterText("John");

      // Tap the 'next' action in the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.next);

      // This should automatically focus the last name
      // which means we don't need to show a new keyboard with a new finder
      tester.testTextInput.enterText("Doe");

      // Tap the 'done' action in the keyboard
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // This should open a SnackBar with the entered name
      await tester.pumpAndSettle();
      expect(find.text("Your name is: John Doe"), findsOneWidget);
    });

  });

  
}
