import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/empty_list_widget.dart';
import 'package:shirasu/ui_common/movie_list_item.dart';
import 'package:shirasu/ui_common/page_error.dart';
import 'package:shirasu/viewmodel/viewmodel_subscribing.dart';
import 'package:shirasu/extension.dart';

part 'subscribing_widget.g.dart';

final _viewmodelSNProvider =
    StateNotifierProvider.autoDispose<ViewModelSubscribing>(
        (_) => ViewModelSubscribing());

@hwidget
Widget subscribingWidget() => useProvider(_viewmodelSNProvider.state).when(
      preInitialized: () => const CenterCircleProgress(),
      loading: () => const CenterCircleProgress(),
      error: () => const PageError(),
      resultEmpty: () => const EmptyListWidget(
        text: Strings.SUBSCRIBING_EMPTY_MSG,
        icon: Icons.history,
      ),
      success: (programData) => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, i) {
          final item = programData.viewerUser.subscribedPrograms[i];
          return MovieListBigItem(
            program: item,
            onTap: () async => context.pushProgramPage(item.id),
          );
        },
        itemCount: programData.viewerUser.subscribedPrograms.length,
      ),
    );
