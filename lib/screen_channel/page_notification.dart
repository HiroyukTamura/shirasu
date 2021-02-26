import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shirasu/model/graphql/channel_data.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/ui_common/page_error.dart';

class PageNotification extends StatelessWidget {
  const PageNotification({@required this.announcements, Key key})
      : super(key: key);

  final UnmodifiableListView<AnnouncementsItem> announcements;
  static const double _SEPARATE_HEIGHT =
      Dimens.CHANNEL_PAGE_VERTICAL_MARGIN * 2;

  @override
  Widget build(BuildContext context) => announcements.isEmpty
      ? const PageErrText(
          text: Strings.CHANNEL_ANNOUNCEMENTS_EMPTY_MSG,
        )
      : ListView.separated(
          itemCount: announcements.length, //0の場合の例外処理
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.MARGIN_OUTLINE,
            vertical: Dimens.CHANNEL_PAGE_VERTICAL_MARGIN,
          ),
          separatorBuilder: (context, index) =>
              const SizedBox(height: _SEPARATE_HEIGHT),
          itemBuilder: _itemBuilder,
        );

  Widget _itemBuilder(BuildContext context, int index) {
    final item = announcements[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('yyyy/MM/dd HH:mm').format(item.publishedAt),
          style: TextStyles.CHANNEL_TIME,
        ),
        const SizedBox(height: 4),
        Text(
          item.title,
          style: TextStyles.channelHeading,
        ),
        const SizedBox(height: 24),
        Text(
          item.text,
          style: TextStyles.DEFAULT_H,
        )
      ],
    );
  }
}
