import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/model/graphql/channel_data.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/screen_channel/screen_channel.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/movie_list_item.dart';
import 'package:shirasu/extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/util/types.dart';

part 'page_movie_list.g.dart';

class PageMovieList extends HookWidget {
  const PageMovieList({
    @required this.channelId,
    @required this.onTapItem,
    Key key,
  }) : super(key: key);

  final OnTapItem onTapItem;
  final String channelId;

  @override
  Widget build(BuildContext context) {
    final sc = useScrollController();
    return useProvider(kPrvViewModelChannel(channelId).state).maybeWhen(
      orElse: () => const SizedBox.shrink(),
      success: (dataWrapper) {
        final showLoadingIndicator =
            dataWrapper.data.channel.programs.nextToken != null;
        final listView = _ListView(
          sc: sc,
          channelPrograms: dataWrapper.data.channel.programs,
          showLoadingIndicator: showLoadingIndicator,
        );
        return _WrappedNotificationListener(
          sc: sc,
          channelId: channelId,
          enabled: !dataWrapper.loading,
          child: listView,
        );
      },
    );
  }
}

@hwidget
Widget _wrappedNotificationListener(
  BuildContext context, {
  @required String channelId,
  @required ScrollController sc,
  @required Widget child,
  @required bool enabled,
}) =>
    NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (enabled &&
            notification is UserScrollNotification &&
            notification.direction == ScrollDirection.idle &&
            sc.position.maxScrollExtent -
                    (Dimens.CIRCULAR_HEIGHT +
                        Dimens.CHANNEL_PAGE_VERTICAL_MARGIN) <
                sc.offset) {
          context.read(kPrvViewModelChannel(channelId)).loadMorePrograms();
          return true;
        }

        return false;
      },
      child: child,
    );

@hwidget
Widget _listView({
  @required ScrollController sc,
  @required ChannelPrograms channelPrograms,
  @required bool showLoadingIndicator,
}) {
  var itemCount = channelPrograms.items.length;
  if (showLoadingIndicator) itemCount++;

  return ListView.builder(
    controller: sc,
    shrinkWrap: true,
    key: ObjectKey(channelPrograms.items.first.hashCode),
    padding: const EdgeInsets.only(
      top: Dimens.CHANNEL_PAGE_VERTICAL_MARGIN,
      bottom: MovieListItemBase.PADDING,
    ),
    itemBuilder: (context, i) {
      if (showLoadingIndicator && i == itemCount - 1)
        return const CenterCircleProgress(
          padding: EdgeInsets.all(Dimens.CHANNEL_PAGE_VERTICAL_MARGIN),
        );
      else {
        final program = channelPrograms.items[i];
        return MovieListItem(
          id: program.id,
          broadcastAt: program.broadcastAt,
          title: program.title,
          onTap: () async => context.pushProgramPage(program.id),
        );
      }
    },
    itemCount: itemCount,
  );
}
