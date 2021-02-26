import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/repository/connectivity_repository.dart';
import 'package:shirasu/repository/connectivity_repository_impl.dart';
import 'package:shirasu/repository/dio_repository.dart';
import 'package:shirasu/repository/graphql_repository.dart';
import 'package:shirasu/repository/graphql_repository_impl.dart';
import 'package:shirasu/repository/dio_client.dart';
import 'package:shirasu/repository/hive_auth_repository.dart';
import 'package:shirasu/repository/logger_repository.dart';
import 'package:shirasu/repository/logger_repository_impl.dart';
import 'package:shirasu/router/global_route_path.dart';
import 'package:shirasu/util/exceptions.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:shirasu/main.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/viewmodel/model/error_msg_common.dart';

abstract class ViewModelBase<T> extends StateNotifier<T>
    with StateTrySetter<T>, ViewModelInitListener, _CommonLocator {
  ViewModelBase(this._reader, T state) : super(state) {
    initialize();
  }

  final Reader _reader;

  @protected
  @override
  T Function<T>(RootProvider<Object, T> provider) get reader => _reader;

  @override
  @protected
  @visibleForTesting
  Future<void> initialize() async {}
}

/// use only in case that we can't use [ViewModelBase]
abstract class ViewModelBaseChangeNotifier extends ChangeNotifier
    with ViewModelInitListener, _CommonLocator {
  ViewModelBaseChangeNotifier(this.reader) : super() {
    initialize();
  }

  @override
  final Reader reader;

  bool _isMounted = true;

  bool get isMounted => _isMounted;

  @override
  @protected
  Future<void> initialize() async {}

  @override
  void dispose() {
    super.dispose();
    _isMounted = false;
  }
}

mixin ViewModelInitListener {
  @protected
  Future<void> initialize() async {}
}

mixin StateTrySetter<T> on StateNotifier<T> {
  @protected
  void trySet(T state) {
    if (mounted) this.state = state;
  }
}

mixin _CommonLocator {
  @protected
  Reader get reader;

  @protected
  void pushAuthExpireScreen() =>
      reader(kPrvAppRouterDelegate).pushPage(const GlobalRoutePath.error(true));

  @protected
  GraphQlRepository get graphQlRepository => reader(kPrvGraphqlRepository);

  @protected
  DioRepository get dioClient => reader(kPrvDioRepository);

  @protected
  ConnectivityRepository get connectivityRepository =>
      reader(kPrvConnectivityRepository);

  @protected
  HiveAuthRepository get hiveAuthRepository => reader(kPrvHiveAuthRepository);

  @protected
  SnackBarMessageNotifier get snackBarMsgNotifier => reader(kPrvSnackBar);

  @protected
  LoggerRepository get logger => reader(kPrvLogger);

  @protected
  ErrorMsgCommon toErrMsg(dynamic e) {
    if (e is UnauthorizedException)
      return e.detectedByTime
          ? const ErrorMsgCommon.authExpired()
          : const ErrorMsgCommon.unAuth();
    else if (e is TimeoutException)
      return const ErrorMsgCommon.networkTimeout();
    else if (e is NetworkDisconnectException)
      return const ErrorMsgCommon.networkDisconnected();
    else
      return const ErrorMsgCommon.unknown();
  }

  @protected
  SnackMsg toNetworkSnack(dynamic e) {
    if (e is TimeoutException)
      return const SnackMsg.networkTimeout();
    else if (e is NetworkDisconnectException)
      return const SnackMsg.networkDisconnected();
    else
      return const SnackMsg.unknown();
  }

  @protected
  Future<void> clearAuthDataAndWebCache() async {
    await hiveAuthRepository.clearAuthData();
    await logger.guardFuture(() async {
      final webView = FlutterWebviewPlugin();
      await webView.cleanCookies();
      await webView.clearCache();
    });
  }
}
