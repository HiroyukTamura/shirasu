import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/screen_main/page_dashboard/channel_list_item.dart';
import 'package:shirasu/viewmodel/model/dashboard_model.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/screen_main/page_dashboard/billboard/billboard_header.dart';
import 'package:shirasu/screen_main/page_dashboard/billboard/heading.dart';
import 'package:shirasu/screen_main/page_dashboard/horizontal_carousels.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/movie_list_item.dart';
import 'package:shirasu/ui_common/page_error.dart';
import 'package:shirasu/viewmodel/viewmodel_dashboard.dart';
import 'package:shirasu/extension.dart';

part 'page_dashboard.g.dart';

final kPrvDashboardViewModel =
    ChangeNotifierProvider.autoDispose<ViewModelDashBoard>(
        (ref) => ViewModelDashBoard(ref.read));

@hwidget
Widget pageDashboardInMainScreen() =>
    useProvider(kPrvDashboardViewModel.select((viewModel) => viewModel.state))
        .when(
      initial: () => const CenterCircleProgress(),
      error: (msg) => PageError(text: msg.value),
      success: (data) {
        final showLoadingIndicator = data.loadingMore ||
            (data.apiData.newProgramsDataList?.isNotEmpty == true &&
                data.apiData.newProgramsDataList?.last?.newPrograms
                        ?.nextToken !=
                    null);
        return _ListViewContent(
          data: data.apiData,
          showLoadingIndicator: showLoadingIndicator,
        );
      },
    );

class _ListViewContent extends HookWidget {
  const _ListViewContent({
    @required this.data,
    @required this.showLoadingIndicator,
  });

  static const _NOW_BROADCASTINGS_LAST = 1;

  final ApiData data;
  final bool showLoadingIndicator;

  @override
  Widget build(BuildContext context) {
    final featurePrgData = data.featureProgramData;
    final newPrgData = data.allNewPrograms;

    final anyNowBroadcastings =
        featurePrgData?.nowBroadcastings?.items?.isNotEmpty == true;

    var itemCount = _NOW_BROADCASTINGS_LAST;

    if (featurePrgData?.comingBroadcastings?.items?.isNotEmpty == true)
      itemCount += 2;
    final comingBroadcastingsLast = itemCount;

    if (data?.listSubscribedPrograms?.viewerUser?.subscribedPrograms?.items
            ?.isNotEmpty ==
        true) itemCount += 2;

    final subscribingLast = itemCount;

    if (featurePrgData?.channels?.items?.isNotEmpty == true) itemCount += 2;

    final channelsLast = itemCount;

    if (newPrgData?.isNotEmpty == true) itemCount += newPrgData.length;

    final controller = useScrollController(keepScrollOffset: false);
    _initScrollControllerListener(context, controller);

    return LayoutBuilder(
      builder: (context, constraints) =>
          NotificationListener<ScrollNotification>(
        onNotification: (notification) =>
            _onScrollNotification(context, controller, notification),
        child: ListView.builder(
            controller: controller,
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: showLoadingIndicator ? itemCount + 1 : itemCount,
            itemBuilder: (context, index) {
              if (index == 0) {
                return anyNowBroadcastings
                    ? BillboardHeader.build(
                        onTapItem: (context, prgId) async =>
                            context.pushProgramPage(prgId),
                        items: featurePrgData.nowBroadcastings.items,
                        constraints: constraints,
                        wideMode: context.isBigScreen,
                      )
                    : const SizedBox(height: 16);
              } else if (index < comingBroadcastingsLast &&
                  _NOW_BROADCASTINGS_LAST != comingBroadcastingsLast) {
                final i = index - _NOW_BROADCASTINGS_LAST;

                if (i == 0)
                  return const Heading(text: Strings.HEADING_UPCOMING);

                return HorizontalCarousels(
                  list: featurePrgData.comingBroadcastings.items
                      .map((it) => HorizontalCarouselItemConf.from(it))
                      .toList(),
                  maxWidth: constraints.maxWidth,
                  constraints: constraints,
                  detailCaption: true,
                  onTapItem: (item, id) async => context.pushProgramPage(id),
                );
              } else if (index < subscribingLast &&
                  comingBroadcastingsLast != subscribingLast) {
                final i = index - comingBroadcastingsLast;

                return i == 0
                    ? const Heading(text: Strings.HEADING_SUBSCRIBING)
                    : HorizontalCarousels(
                        list: data?.listSubscribedPrograms?.viewerUser
                            ?.subscribedPrograms?.items
                            ?.map((it) => HorizontalCarouselItemConf.from(it))
                            ?.toList(),
                        maxWidth: constraints.maxWidth,
                        constraints: constraints,
                        detailCaption: true,
                        onTapItem: (item, id) async =>
                            context.pushProgramPage(id),
                      );
              } else if (index < channelsLast &&
                  subscribingLast != channelsLast) {
                final i = index - subscribingLast;

                return i == 0
                    ? const Heading(text: Strings.HEADING_CHANNEL)
                    : ChannelListItem(
                        channels: featurePrgData.channels,
                        onTap: (context, channelId) async =>
                            context.pushChannelPage(channelId),
                      );
              } else if (index < itemCount || !showLoadingIndicator) {
                final i = index - channelsLast;

                if (i == 0) return const Heading(text: Strings.HEADING_NEW_PRG);

                final item = newPrgData[i - 1];
                return MovieListItem(
                  onTap: () async => context.pushProgramPage(item.id),
                  title: item.title,
                  id: item.id,
                  broadcastAt: item.broadcastAt,
                );
              } else
                return const CenterCircleProgress();
            }),
      ),
    );
  }

  void _initScrollControllerListener(
          BuildContext context, ScrollController controller) =>
      useEffect(() {
        void listener() => context
            .read(kPrvDashboardViewModel)
            .updateScrollOffset(controller.offset);
        controller.addListener(listener);
        return () => controller.removeListener(listener);
      }, [controller]);

  bool _onScrollNotification(BuildContext context, ScrollController controller,
      ScrollNotification notification) {
    if (showLoadingIndicator &&
        notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        controller.position.maxScrollExtent - Dimens.CIRCULAR_HEIGHT <
            controller.offset) {
      context.read(kPrvDashboardViewModel).loadMoreNewPrg();
      return true;
    }

    return false;
  }
}
