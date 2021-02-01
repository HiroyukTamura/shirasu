import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:intl/intl.dart';
import 'package:shirasu/client/url_util.dart';
import 'package:shirasu/model/graphql/featured_programs_data.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/ui_common/stacked_inkwell.dart';
import 'package:shirasu/util.dart';

part 'billboard_expanded.g.dart';

class BillboardExpanded extends StatelessWidget {
  BillboardExpanded({
    Key key,
    @required this.item,
    @required this.btmPadding,
    @required this.onTap,
  })  : _thumbnailUrl = UrlUtil.getThumbnailUrl(item.id),
        _channelLogoUrl = UrlUtil.getChannelLogoUrl(item.channelId),
        super(key: key);

  static const double _CHANNEL_LOGO_SIZE = 24;

  final Item item;
  final String _thumbnailUrl;
  final String _channelLogoUrl;
  final GestureTapCallback onTap;
  final bool btmPadding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          bottom: btmPadding ? 48 : 32,
          top: 16,
        ),
        child: StackedInkWell(
          onTap: onTap,
          child: Column(
            children: [
              _thumbnail(),
              const SizedBox(height: 16),
              _title(),
              const SizedBox(height: 8),
              _channel(),
              const SizedBox(height: 24),
              _timeStamp(context),
            ],
          ),
        ),
      );

  Widget _thumbnail() => AspectRatio(
      aspectRatio: Dimens.IMG_RATIO,
      child: CachedNetworkImage(
        imageUrl: _thumbnailUrl,
        errorWidget: Util.defaultPrgThumbnail,
      ),
    );

  Widget _title() => _ItemPadding(
    child: Text(
        item.title,
        style: TextStyles.DASHBOARD_BILLBOARD_TITLE,
      ),
  );

  Widget _channel() => _ItemPadding(
    child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: _channelLogoUrl,
            height: _CHANNEL_LOGO_SIZE,
            width: _CHANNEL_LOGO_SIZE,
            errorWidget: Util.defaultChannelIcon,
          ),
          const SizedBox(width: 16),
          Text(
            item.channel.name,
            style: TextStyles.DASHBOARD_BILLBOARD_CHANNEL_NAME,
          ),
        ],
      ),
  );

  Widget _timeStamp(BuildContext context) => _ItemPadding(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            DateFormat('yyyy/MM/dd HH:mm').format(item.broadcastAt),
            style: TextStyles.DASHBOARD_BILLBOARD_DATETIME,
          ),
        ],
      ),
  );
}

@swidget
Widget _itemPadding({@required Widget child}) => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: Dimens.DASHBOARD_OUTER_MARGIN,
  ),
  child: child,
);
