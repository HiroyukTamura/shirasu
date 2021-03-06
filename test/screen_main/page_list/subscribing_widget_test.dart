import 'package:flutter/material.dart';
import 'package:shirasu/screen_main/page_list/subscribing_widget.dart';

import '../../widget_test_util/test_runner_base.dart';
import '../../widget_test_util/test_runner_on_page_error.dart';
import '../../widget_test_util/test_runner_on_page_list.dart';

void main() => _TestRunner()
    ..initTestOnPageList()
    ..runTestGroup('SubscribingWidget', goldenNamePrefix: 'SubscribingWidget')
    ..runTestOnPageList('SubscribingWidget');

class _TestRunner extends TestRunnerBase
    with TestRunnerOnPageError, TestRunnerOnPageList {
  _TestRunner()
      : super(
          () => const Scaffold(
            body: SubscribingWidget(),
          ),
          goldenNamePrefix: 'SubscribingWidget',
        );
}
