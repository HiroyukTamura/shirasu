import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/screen_main/page_list/page_subscribing.dart';

import '../../mock_viewmodel/viewmodel_subscribing_pre_initialized.dart';
import '../../mock_viewmodel/viewmodel_watch_history_pre_initialized.dart';
import '../../widget_test_util/test_runner_base.dart';

void main() => _TestRunner().runTest();

class _TestRunner extends TestRunnerBase {
  _TestRunner()
      : super(
          () => Scaffold(
            body: PageListInMainScreen(
              initialPage: PageListTabPage.SUBSCRIBING,
            ),
          ),
          goldenNamePrefix: 'PageListInMainScreen',
        );

  static const _TEST_NAME_PAGE_SUBSCRIBING = 'PageSubscribing';
  static const _TEST_NAME_PAGE_CHANGED = 'PageChanged';

  void runTest() => group('PageListInMainScreen', () {
        testGoldensSimple(
          testName: _TEST_NAME_PAGE_SUBSCRIBING,
          overrides: [
            kOverrideViewModelSubscribingPreInitialized,
            kOverrideViewModelWatchHistoryPreInitialized,
          ],
        );
        testGoldensSimple(
            testName: _TEST_NAME_PAGE_CHANGED,
            overrides: [
              kOverrideViewModelSubscribingPreInitialized,
              kOverrideViewModelWatchHistoryPreInitialized,
            ],
            onScenarioCreate: (tester, key) async {
              final tabBtn = find.descendant(
                of: find.byKey(key),
                matching: find.text(Strings.TAB_WATCH_HISTORY),
              );
              await tester.tap(tabBtn);
              await tester.pump(1.seconds);
            });
      });
}
