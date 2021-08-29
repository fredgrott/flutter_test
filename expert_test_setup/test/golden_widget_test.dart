// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:expert_test_setup/app_vars.dart';
import 'package:expert_test_setup/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'package:flutter_test/flutter_test.dart';

import 'package:golden_toolkit/golden_toolkit.dart';

// so we know what to match
String myTitle = myAppTitle;

// NOTE: When we need to start testing for the MaterialApp and
//       CupertinoApp looks we can simply mock the root as MaterialApp and CupertinoApp
//       GoldenToolkit Builders as we then pass a platform target as part of the mock
//       so it will look that specific no matter what simulator or emulator it runs on.
//
//       Currently there is no CupertinoApp wrapper but, one could implement one from this:
//
//        ```
//         WidgetWrapper materialAppWrapper({
//             TargetPlatform platform = TargetPlatform.android,
//             Iterable<LocalizationsDelegate<dynamic>>? localizations,
//             NavigatorObserver? navigatorObserver,
//             Iterable<Locale>? localeOverrides,
//             ThemeData? theme,
//         }) {
//          return (child) => MaterialApp(
//             localizationsDelegates: localizations,
//              supportedLocales: localeOverrides ?? const [Locale('en')],
//               theme: theme?.copyWith(platform: platform),
//                 debugShowCheckedModeBanner: false,
//                home: Material(child: child),
//             navigatorObservers: [
//          if (navigatorObserver != null) navigatorObserver,
//        ],
//      );
// }
// ```
// And to use it will be like this:
//  ```
//   await tester.pumpWidgetBuilder(
//        yourWidget,
//        wrapper: materialAppWrapper(
//         theme: ThemeData.light(),
//          platform: TargetPlatform.android,
//        ),
//      );
//  ```
//
// For Flutter Platform Widgets I would have to do the root build using the normal FPW root way but then
// two variations of that builder one for Material and one for Cupertino.
//
// Something like:
// await tester.pumpWidgetBuilder(
//        yourWidget,
//        wrapper: myFPWAppWrapper(
//         theme: ThemeData.light(),
//          platform: TargetPlatform.android,
//        ),
//      );
//

/// I use eBays golden_toolkit
/// https://pub.dev/packages/golden_toolkit
///
/// This gets configured in the flutter-test_config file and only for widget tests.
/// As screens and complexities increase one will  mock or fake an app scenario
/// so one can test how screen should appear to than act as matcher to
/// test results.
///
///
/// @author Fredrick Allan Grott
// ignore: long-method
void main() {
  // ignore: no-empty-block
  setUp(() async {});

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
  });

  // Remember this runs once after ALL tests or groups
  // ignore: no-empty-block
  tearDownAll(() async {});

  // Remember this runs after EACH test or group
  // ignore: no-empty-block
  tearDown(() async {
    // Code that clears caches can go here
  });

  group('Basic Golden Tests ', () {
    testWidgets('Golden test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(
        home: MyHomePage(
          message: myHomePageMessage,
          title: myAppTitle,
        ),
      ));
      await expectLater(find.byType(MyApp), matchesGoldenFile('main.png'));
    });
    testGoldens('DeviceBuilder ', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.phone,
          Device.iphone11,
          Device.tabletPortrait,
          Device.tabletLandscape,
        ])
        ..addScenario(
          widget: MyHomePage(
            title: myTitle,
            message: myHomePageMessage,
          ),
          name: 'default page',
        );
      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(
        tester,
        "my_home_page_single_scenario_more_devices",
      );
    });
  });

  group('Multiple Scenarios', () {
    testGoldens(
      'Multiple Scenarios with onCreate',
      (WidgetTester tester) async {
        // ignore: unused_local_variable
        final builder = DeviceBuilder()
          ..overrideDevicesForAllScenarios(devices: [
            Device.phone,
            Device.iphone11,
            Device.tabletPortrait,
            Device.tabletLandscape,
          ])
          ..addScenario(
            widget: MyHomePage(
              title: myAppTitle,
              message: myHomePageMessage,
            ),
            name: 'default page',
          )
          ..addScenario(
            widget: MyHomePage(
              title: myAppTitle,
              message: myHomePageMessage,
            ),
            name: 'tap once',
            onCreate: (scenarioWidgetKey) async {
              final finder = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byIcon(Icons.add),
              );
              expect(finder, findsOneWidget);
              await tester.tap(finder);
            },
          )
          ..addScenario(
            widget: MyHomePage(
              title: myAppTitle,
              message: myHomePageMessage,
            ),
            name: 'tap five times',
            onCreate: (scenarioWidgetKey) async {
              final finder = find.descendant(
                of: find.byKey(scenarioWidgetKey),
                matching: find.byIcon(Icons.add),
              );
              expect(finder, findsOneWidget);

              await tester.tap(finder);
              await tester.tap(finder);
              await tester.tap(finder);
              await tester.tap(finder);
              await tester.tap(finder);
            },
          );
        await tester.pumpDeviceBuilder(builder);

        await screenMatchesGolden(
          tester,
          'my_home_page_multiple_scenarios',
        );
      },
    );
  });
}
