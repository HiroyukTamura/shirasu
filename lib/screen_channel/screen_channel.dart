import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/di/url_util.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/styles.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/screen_channel/content_cell.dart';
import 'package:shirasu/screen_channel/page_channel_detail.dart';
import 'package:shirasu/screen_channel/page_movie_list.dart';
import 'package:shirasu/screen_channel/page_notification.dart';
import 'package:shirasu/screen_detail/billing_btn.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/page_error.dart';
import 'package:shirasu/viewmodel/viewmodel_channel.dart';

final _channelSProvider = StateProvider.autoDispose
    .family<ViewModelChannel, String>((_, id) => ViewModelChannel(id));

class ScreenChannel extends StatefulHookWidget {
  const ScreenChannel({Key key, @required this.channelId}) : super(key: key);

  final String channelId;

  @override
  _ScreenChannelState createState() => _ScreenChannelState(channelId);
}

class _ScreenChannelState extends State<ScreenChannel>
    with AfterLayoutMixin<ScreenChannel> {
  _ScreenChannelState(this._channelId)
      : _headerUrl = UrlUtil.getChannelHeaderUrl(_channelId),
        _logoUrl = UrlUtil.getChannelLogoUrl(_channelId);

  static const double _CHANNEL_LOGO_SIZE = 32;
  static const _BILLING_PROMO_CHANNEL = '月額6600円で購読';

  final String _channelId;
  final String _headerUrl;
  final String _logoUrl;

  int _tabIndex = 0;

  @override
  void afterFirstLayout(BuildContext context) =>
      context.read(_channelSProvider(_channelId)).state.initialize();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: useProvider(_channelSProvider(_channelId).select((it) => it.state.state)).when(
          preInitialized: () => const CenterCircleProgress(),
          loading: () => const CenterCircleProgress(),
          error: () => const PageError(),
          success: (channelData) {
            final isAnnouncementEmpty = channelData.channel
                .announcements.items.isEmpty;
            final initialLength = isAnnouncementEmpty ? 2 : 3;
            final tabController = useTabController(
                initialLength: initialLength, initialIndex: _tabIndex);
            tabController.addListener(() => _tabIndex = tabController.index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: Dimens.HEADER_ASPECT,
                  child: CachedNetworkImage(imageUrl: _headerUrl),
                ),
                const SizedBox(height: 24),
                ContentCell(
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        height: _CHANNEL_LOGO_SIZE,
                        width: _CHANNEL_LOGO_SIZE,
                        imageUrl: _logoUrl,
                      ),
                      const SizedBox(width: 24),
                      Text(
                        channelData.channel.name,
                        style: TextStyles.CHANNEL_NAME,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ContentCell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (channelData.channel.subscriptionPlan
                          ?.viewerPurchasedPlan?.isActive ==
                          true)
                        PurchasedBannerMedium()
                      else
                        if (channelData.channel.subscriptionPlan
                            ?.isPurchasable)
                          const BillingBtnMedium(
                              text: _BILLING_PROMO_CHANNEL) //todo fix
                        else
                          const SizedBox.shrink(),
                      IconButton(
                        icon: Icon(
                          Icons.add_alert,
                          color: Styles.colorTextSub,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ContentCell(
                  child: TabBar(
                      labelColor: Colors.white,
                      controller: tabController,
                      isScrollable: true,
                      tabs: [
                        const Tab(text: Strings.CHANNEL_TAB_DESC),
                        const Tab(text: Strings.CHANNEL_TAB_MOVIE),
                        if (!isAnnouncementEmpty)
                          const Tab(text: Strings.CHANNEL_TAB_NOTIFICATION),
                      ]),
                ),
                SizedBox(
                  height: .5,
                  child: ColoredBox(
                    color: Colors.white.withOpacity(.7),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      PageChannelDetail(text: channelData.channel
                          .detail),
                      PageMovieList(channelPrograms: channelData.channel
                          .programs),
                      if (!isAnnouncementEmpty)
                        PageNotification(
                            announcements:
                            channelData.channel.announcements),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      );
}
