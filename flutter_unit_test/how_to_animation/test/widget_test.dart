// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:how_to_animation/main.dart';

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

    testWidgets("How do I test an animation?", (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      final Finder startAnimationFinder = find.text("Start animation");
      final Finder animatedBoxFinder = find.byKey(const Key("animatedBox"));

      expect(startAnimationFinder, findsOneWidget);
      expect(animatedBoxFinder, findsOneWidget);

      // The box starts off with a height of 0
      final RenderConstrainedBox animatedBox =
          tester.renderObject(animatedBoxFinder);
      expect(animatedBox.size.height, 0);

      // Once we start the animation
      await tester.tap(startAnimationFinder);
      await tester.pump();

      // and wait 100 milliseconds
      await tester.pump(const Duration(milliseconds: 100));
      // we expect the height to grow from 0 to 10
      expect(animatedBox.size.height, 10);

      // after another 100 milliseconds it should grow to 20
      await tester.pump(const Duration(milliseconds: 100));
      expect(animatedBox.size.height, 20);

      await tester.pump(const Duration(milliseconds: 100));
      // and then 30
      expect(animatedBox.size.height, 30);

      await tester.pump(const Duration(milliseconds: 100));
      // and then 40
      expect(animatedBox.size.height, 40);

      await tester.pump(const Duration(milliseconds: 100));
      // and then 50
      expect(animatedBox.size.height, 50);

      await tester.pump(const Duration(milliseconds: 500));
      // and then after another 500 milliseconds, the animation should be
      // complete and be a total height of 100
      expect(animatedBox.size.height, 100);
    });

  });

  
}
