import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/dialog/user_location_dialog.dart';
import 'package:shirasu/main.dart';
import 'package:shirasu/model/base_model.dart';
import 'package:shirasu/model/viewer.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/router/screen_main_route_path.dart';
import 'package:shirasu/screen_main/page_setting/email_status_label.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_birthdate.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_job.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_load_more.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_location.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_title.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_payment_method.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_invoice_history.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_seem.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_subscribed_channel.dart';
import 'package:shirasu/screen_main/page_setting/list_tile_top.dart';
import 'package:shirasu/ui_common/center_circle_progress.dart';
import 'package:shirasu/ui_common/movie_list_item.dart';
import 'package:shirasu/ui_common/page_error.dart';
import 'package:shirasu/viewmodel/model_setting.dart';
import 'package:shirasu/viewmodel/viewmodel_setting.dart';
import 'package:shirasu/model/auth_data.dart';
import 'package:shirasu/extension.dart';

final settingViewModelSProvider =
    StateNotifierProvider.autoDispose<ViewModelSetting>(
        (ref) => ViewModelSetting(ref));

class PageSettingInMainScreen extends StatefulHookWidget {
  const PageSettingInMainScreen({Key key}) : super(key: key);

  @override
  PageSettingInMainScreenState createState() => PageSettingInMainScreenState();
}

class PageSettingInMainScreenState extends State<PageSettingInMainScreen>
    with AfterLayoutMixin<PageSettingInMainScreen> {
  @override
  void afterFirstLayout(BuildContext context) =>
      context.read(settingViewModelSProvider).initialize();

  @override
  Widget build(BuildContext context) =>
      useProvider(settingViewModelSProvider.state
          .select((it) => it.settingModelState)).when(
        preInitialized: () => const CenterCircleProgress(),
        loading: () => const CenterCircleProgress(),
        error: () => const PageError(),
        success: (data) => ListView.builder(
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.SETTING_OUTER_MARGIN),
          itemBuilder: (context, i) {
            final threshHolds = _Thresholds();

            if (i <= threshHolds.threshold)
              return _genListItemAboveCreditCard(
                context,
                data,
                i,
              );

            threshHolds.swap(data.viewer.paymentMethods.length);

            if (i <= threshHolds.threshold)
              return ListTilePaymentMethod(
                paymentMethod: data.viewer
                        .paymentMethods[i - threshHolds.preThreshHold - 1]
                    as BasePaymentMethod,
              ); //todo why cast?

            threshHolds.swap(2);

            if (i <= threshHolds.threshold) {
              switch (i - threshHolds.preThreshHold - 1) {
                case 0:
                  return const ListTileSeem(
                    paddingTop: false,
                    paddingBtm: true,
                  );
                case 1:
                  return ListTileTitle(
                    title: Strings.TITLE_SUBSCRIBED_CHANNELS,
                    showEmptyText: data.viewerUser.subscribedChannels.isEmpty,
                    isCreditCard: false,
                  );
              }
              throw Exception();
            }

            threshHolds.swap(data.viewerUser.subscribedChannels.length);

            if (i <= threshHolds.threshold) {
              final index = i - threshHolds.preThreshHold - 1;
              return ListTileSubscribedChannel(
                subscribedChannel: data.viewerUser.subscribedChannels[index],
              );
            }

            threshHolds.swap(2);

            if (i <= threshHolds.threshold) {
              switch (i - threshHolds.preThreshHold - 1) {
                case 0:
                  return const ListTileSeem(
                    paddingBtm: true,
                    paddingTop: true,
                  );
                case 1:
                  return ListTileTitle(
                    title: Strings.TITLE_PURCHASE_HISTORY,
                    showEmptyText: data.viewerUser.invoiceHistory.items.isEmpty,
                    isCreditCard: false,
                  );
              }
              throw Exception();
            }

            threshHolds.swap(data.viewerUser.invoiceHistory.items.length);

            if (i <= threshHolds.threshold) {
              final index = i - threshHolds.preThreshHold - 1;
              return ListTileInvoiceHistory(
                invoiceHistoryItem: data.viewerUser.invoiceHistory.items[index],
              );
            }

            threshHolds.swap(2);

            if (i <= threshHolds.threshold) {
              switch (i - threshHolds.preThreshHold - 1) {
                case 0:
                  return const ListTileSeem(
                    paddingBtm: true,
                    paddingTop: true,
                  );
                case 1:
                  return ListTileTitle(
                    title: Strings.TITLE_WATCH_HISTORY,
                    showEmptyText: data.viewerUser.watchHistories.items.isEmpty,
                    isCreditCard: false,
                  );
              }
              throw Exception();
            }

            threshHolds.swap(data.viewerUser.watchHistories.items.length);

            if (i <= threshHolds.threshold) {
              final index = i - threshHolds.preThreshHold - 1;
              final program =
                  data.viewerUser.watchHistories.items[index].program;
              return MovieListItem(
                program: program as BaseProgram, //todo why cast?
                onTap: () async => context
                    .read(appRouterProvider)
                    .delegate
                    .pushPage(GlobalRoutePath.program(program.id)),
              );
            }

            return const ListTileLoadMore();
          },
          itemCount: 15 +
              data.viewer.paymentMethods.length +
              data.viewerUser.subscribedChannels.length +
              data.viewerUser.invoiceHistory.items.length +
              data.viewerUser.watchHistories.items.length,
        ),
      );

  static Widget listItem({
    @required String title,
    @required String subTitle,
    GestureTapCallback onTap,
  }) =>
      ListTile(
        title: Text(title),
        subtitle: Text(
          subTitle,
          style: TextStyles.SETTING_SUBTITLE,
        ),
        onTap: onTap,
      );

  static Widget listItemUserName(User user) {
    String userName =
        '${user.httpsShirasuIoUserAttribute.familyName} ${user.httpsShirasuIoUserAttribute.givenName}';
    if (user.httpsShirasuIoUserAttribute.familyNameReading != null &&
        user.httpsShirasuIoUserAttribute.givenNameReading != null)
      userName +=
          '(${user.httpsShirasuIoUserAttribute.familyNameReading} ${user.httpsShirasuIoUserAttribute.givenNameReading})';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.SETTING_OUTER_MARGIN, vertical: 8),
      title: const Text(Strings.FULL_NAME_LABEL),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyles.SETTING_SUBTITLE,
          ),
          const SizedBox(height: 4),
          const Text(
            Strings.FULL_NAME_NOTICE,
            style: TextStyle(
              height: 1.3,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }

  static Widget _genListItemAboveCreditCard(
    BuildContext context,
    Viewer viewer,
    int index,
  ) {
    switch (index) {
      case 0:
        return ListTileTop(
            iconUrl: viewer.viewerUser.icon, userName: viewer.viewerUser.name);
      case 1:
        return listItemUserName(ViewModelSetting.dummyUser);
      case 2:
        return ListItemEmail(
          user: ViewModelSetting.dummyUser,
        );
      case 3:
        return const ListTileBirthDate();
      case 4:
        return const ListTileJob();
      case 5:
        return ListTileLocation();
      case 6:
        return const ListTileSeem(
          paddingBtm: false,
          paddingTop: true,
        );
      case 7:
        return ListTileTitle(
          title: Strings.TITLE_CREDIT_CARD,
          showEmptyText: viewer.viewer.paymentMethods.isEmpty,
          isCreditCard: true,
        );
      default:
        throw Exception('unexpected index: $index');
    }
  }
}

class _Thresholds {
  int _preThreshHold = 7;
  int _threshold = 7;

  void swap(int num) {
    _preThreshHold = _threshold;
    _threshold += num;
  }

  int get preThreshHold => _preThreshHold;

  int get threshold => _threshold;
}
