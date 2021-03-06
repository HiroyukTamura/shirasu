import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/repository/url_util.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/font_size.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/router/global_route_path.dart';
import 'package:shirasu/ui_common/branding.dart';
import 'package:shirasu/ui_common/msg_ntf_listener.dart';
import 'package:shirasu/ui_common/no_effect_scroll_behavior.dart';
import 'package:shirasu/ui_common/ui_util.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/extension.dart';

part 'screen_pre_login.g.dart';

final _kPrvSnackBarMsgNotifier =
    StateNotifierProvider.autoDispose<SnackBarMessageNotifier>(
        (ref) => SnackBarMessageNotifier());

final _kPrvSnackMsg = Provider.autoDispose<SnackData>((ref) {
  final state = ref.watch(_kPrvSnackBarMsgNotifier.state);
  return SnackData(
    state.snackMsg,
    Dimens.SNACK_BAR_DEFAULT_MARGIN,
  );
});

class ScreenPreLogin extends StatelessWidget {
  const ScreenPreLogin();

  static const _NOTE_LIST = [
    Strings.PRE_LOGIN_NOTE_1,
    Strings.PRE_LOGIN_NOTE_2,
    Strings.PRE_LOGIN_NOTE_3
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: SnackEventListener(
            provider: _kPrvSnackMsg,
            child: Stack(
              children: [
                const AnimatedBackground(),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 24,
                    left: 24,
                    bottom: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: const NoEffectScrollBehavior(),
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 48),
                            children: _listViewChildren(),
                          ),
                        ),
                      ),
                      _Button(
                        text: Strings.PRE_LOGIN_REGISTER_BTN_VALUE,
                        btnColor: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        onTap: () => _launchUrl(context, UrlUtil.URL_HOME),
                      ),
                      _Button(
                        text: Strings.PRE_LOGIN_LOGIN_BTN_VALUE,
                        btnColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onTap: () => _onTapLogin(context),
                      ),
                      Row(
                        children: [
                          _FooterText(
                            text: Strings.FOOTER_BTN_SOURCE_VALUE,
                            onTap: () =>
                                _launchUrl(context, UrlUtil.URL_GITHUB),
                          ),
                          _FooterText(
                            text: Strings.FOOTER_BTN_PRIVACY_VALUE,
                            onTap: () =>
                                _launchUrl(context, UrlUtil.URL_LP_POLICY),
                          ),
                        ],
                      ),
                    ].joinWith(() => const SizedBox(height: 24)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  List<Widget> _listViewChildren() {
    final notes = _NOTE_LIST
        .map<Widget>((text) => _Note(
              text: text,
            ))
        .joinWith(() => const SizedBox(height: 16));
    return [
      const HeaderLogo(),
      const SizedBox(
        height: 48,
      ),
      ...notes
    ];
  }

  void _launchUrl(BuildContext context, String url) => Util.launchUrl(
        context,
        url,
        () => context
            .read(_kPrvSnackBarMsgNotifier)
            .notifyMsg(const SnackMsg.unknown(), false),
      );

  void _onTapLogin(BuildContext context) =>
      context.pushPage(const GlobalRoutePath.auth());
}

@swidget
Widget _footerText(
  BuildContext context, {
  @required String text,
  @required VoidCallback onTap,
}) =>
    Expanded(
      child: Center(
        child: TextButton(
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );

@swidget
Widget _button(
  BuildContext context, {
  @required String text,
  @required Color btnColor,
  @required Color textColor,
  @required VoidCallback onTap,
}) =>
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: kCircleBorderRadius,
          ),
          primary: btnColor,
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: Theme.of(context).buttonTheme.padding.horizontal,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: FontSize.S16,
            height: TextHeight.TEXT_HEIGHT,
          ),
        ),
      ),
    );

@swidget
Widget _note(
  BuildContext context, {
  @required String text,
}) =>
    Row(
      children: [
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              height: TextHeight.TEXT_HEIGHT,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
