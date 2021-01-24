import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/src/framework.dart';
import 'package:shirasu/router/global_app_state.dart';
import 'package:shirasu/router/navigation_value_key_handler.dart';
import 'package:shirasu/router/screen_main_route_path.dart';
import 'package:shirasu/screen_auth/screen_auth.dart';
import 'package:shirasu/screen_channel/screen_channel.dart';
import 'package:shirasu/screen_detail/screen_detail/screen_detail.dart';
import 'package:shirasu/screen_image_lisence/screen_image_license.dart';
import 'package:shirasu/screen_intro/screen_intro.dart';
import 'package:shirasu/screen_main/page_dashboard/page_dashboard.dart';
import 'package:shirasu/screen_main/screen_main.dart';
import 'package:shirasu/screen_oss_licence/screen_oss_licence.dart';
import 'package:tuple/tuple.dart';

import 'on_pop_page_mixin.dart';

class AppRouterDelegate extends RouterDelegate<GlobalRoutePathBase>
    with ChangeNotifier, OnPopPageMixin<GlobalRoutePathBase>, PlayerPopRouteMixin<GlobalRoutePathBase> {
  AppRouterDelegate(this.ref) : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  final GlobalAppState appState = GlobalAppState.instance;

  @override
  final ProviderReference ref;

  @override
  Widget build(BuildContext context) {
    final pageList = appState.list
        .map<Tuple2<String, Widget>>((pathData) {
          final screen = GlobalRoutePathBase.wrappedWhenRough(
            pathData,
            intro: () => ScreenIntro(),
            error: () => throw UnimplementedError(),
            channel: (channelId) => ScreenChannel(channelId: channelId),
            program: (programId) => ScreenDetail(id: programId),
            ossLicense: () => const ScreenOssLicense(),
            auth: () => const ScreenAuth(),
            mainPage: () => const ScreenMain(),
            imgLicense: () => const ScreenImageLicense(),
          );
          final location = NavigationValueKeyHandler.getValueKey(pathData);
          return Tuple2(location, screen);
        })
        .map((tuple) => MaterialPage(
              key: ValueKey(tuple.item1),
              child: tuple.item2,
            ))
        .toList();

    return createNavigator(pageList);
  }

  @override
  void dispose() {
    super.dispose();
    appState.removeListener(notifyListeners);
  }

  @override
  Future<void> setNewRoutePath(GlobalRoutePathBase configuration) async =>
      appState.push(configuration);

  @override
  Future<bool> popRoute() async => kickPopRoute(_popRouteAsDefault);

  Future<void> pushPage(GlobalRoutePath path) => setNewRoutePath(path);

  Future<void> swapPageInMainScreen(PathDataMainPageBase path) =>
      setNewRoutePath(path);

  /// copy of [PopNavigatorRouterDelegateMixin.popRoute]
  Future<bool> _popRouteAsDefault() {
    final NavigatorState navigator = navigatorKey?.currentState;
    if (navigator == null)
      return SynchronousFuture<bool>(false);
    return navigator.maybePop();
  }
}
