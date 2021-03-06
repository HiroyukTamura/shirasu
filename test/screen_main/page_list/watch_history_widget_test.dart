// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shirasu/model/result.dart';
import 'package:shirasu/screen_main/page_list/watch_history_widget.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/movie_list_item.dart';

import '../../mock_repository/connected_connected.dart';
import '../../mock_repository/hive_auth_empty.dart';
import '../../mock_repository/logger.dart';
import '../../mock_viewmodel/viewmodel_watch_history_no_loadmore.dart';
import '../../widget_test_util/test_name_common.dart';
import '../../widget_test_util/test_runner_base.dart';
import '../../widget_test_util/test_runner_on_page_error.dart';
import '../../widget_test_util/test_runner_on_page_list.dart';

/// test for [WatchHistoryWidget]
Future<void> main() async {
  _TestRunner()
    ..initTestOnPageList()
    ..runTestGroup('WatchHistoryWidget', goldenNamePrefix: 'WatchHistoryWidget')
    ..runTestOnPageList('WatchHistoryWidget')
    ..runTestLoadingMore();
}

class _TestRunner extends TestRunnerBase
    with TestRunnerOnPageError, TestRunnerOnPageList {
  _TestRunner()
      : super(
          () => const Scaffold(
            body: WatchHistoryWidget(),
          ),
          goldenNamePrefix: 'WatchHistoryWidget',
        );

  /// todo implement load more action
  void runTestLoadingMore() => group(
        'WatchHistoryWidget',
        () {
          testGoldensSimple(
            testName: 'NoLoadingMore',
            overrides: [
              kOverrideConnectedRepositoryConnectedImpl,
              kOverrideEmptyHiveAuthRepository,
              overrideGraphQl,
              kOverrideViewModelWatchHistoryNoLoadMore,
              ...defaultOverride,
            ],
            onPostBuild: (tester) async {
              await _scrollToBottom(tester);
              _findLoadMoreCircleProgress(findsNothing);
            },
          );

          testGoldensSimple(
            testName: 'LoadingMore',
            overrides: [
              kOverrideConnectedRepositoryConnectedImpl,
              kOverrideEmptyHiveAuthRepository,
              overrideGraphQlLoadableMoreHistory,
              kOverrideViewModelWatchHistoryNoLoadMore,
              ...defaultOverride,
            ],
            onPostBuild: (tester) async {
              await _scrollToBottom(tester);
              _findLoadMoreCircleProgress(findsOneWidget);
            },
          );

          // todo not work...
          // testGoldensSimple(
          //   testName: '$_TEST_NAME_PREFIX_INTEGRATE$_TEST_NAME_LOADING_MORE',
          //   overrides: [
          //     kOverrideConnectedRepositoryConnectedImpl,
          //     kOverrideEmptyHiveAuthRepository,
          //     kPrvHivePrefRepository
          //         .overrideWithValue(const HivePrefEmptyRepositoryImpl(false)),
          //     overrideGraphQlLoadableMoreHistory,
          //   ],
          //   onScenarioCreate: (tester, scenarioWidgetKey) async {
          //     await _scrollToBottom(tester, scenarioWidgetKey);
          //     _findLoadMoreCircleProgress(scenarioWidgetKey, findsOneWidget);
          //     await tester.pump(3.seconds);
          //     _findLoadMoreCircleProgress(scenarioWidgetKey, findsNothing);
          //   },
          // );
        },
      );

  /// [WidgetTester.ensureVisible] is not work...
  static Future<void> _scrollToBottom(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      print('scroll down! i: $i');
      await _scrollDown(tester);
      final scrollToEnd = await _isScrollToEnd();
      if (scrollToEnd) break;
    }
  }

  static Future<void> _scrollDown(WidgetTester tester) async =>
      tester.fling(find.byType(ListView), const Offset(0, -500), 2000);

  static Future<bool> _isScrollToEnd() async => Result.guard(
        const TestLogger(),
        () => expect(
            find.text(TestNameCommon.WATCH_HISTORY_LAST_TITLE), findsOneWidget),
        logError: false,
      ).when(
        success: (_) => true,
        failure: (_) => false,
      );

  static void _findLoadMoreCircleProgress(Matcher matcher) {
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(CenterCircleProgress), matcher);
    expect(find.byType(MovieListItem), findsWidgets);
  }
}
