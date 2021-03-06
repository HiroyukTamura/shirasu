import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:uuid/uuid.dart';
import 'package:shirasu/viewmodel/model/notification_msg.dart';

part 'message_notifier.freezed.dart';

class SnackBarMessageNotifier extends StateNotifier<SnackMsgEvent> {
  SnackBarMessageNotifier() : super(null);

  void notifyMsg(SnackMsg snackMsg, bool btmAppBarMargin) =>
      state = SnackMsgEvent(snackMsg, btmAppBarMargin);
}

class SnackMsgEvent {
  SnackMsgEvent(this.snackMsg, this.btmAppBarMargin);

  final bool btmAppBarMargin;
  final SnackMsg snackMsg;
  final String _eventKey = Uuid().v4(); // ignore: unused_field
}

@freezed
abstract class SnackMsg with _$SnackMsg, NotificationMsg {
  const factory SnackMsg.unknown() = _SnackMsgUnknownErr;

  const factory SnackMsg.noMoreItem() = _SnackMsgNoMoreItem;

  const factory SnackMsg.cantOpenUrl() = _SnackMsgCantOpenurl;

  const factory SnackMsg.urlCopied() = _SnackMsgUrlCopied;

  const factory SnackMsg.networkDisconnected() = _SnackMsgNetworkDisconnected;

  const factory SnackMsg.networkTimeout() = _SnackMsgNetworkTimeout;

  const factory SnackMsg.fcmSubscribe() = _SnackMsgFcmSubscribe;

  const factory SnackMsg.fcmUnsubscribe() = _SnackMsgFcmUnsubscribe;

  const factory SnackMsg.loginInputInvalid() = _SnackMsgLoginInputInvalid;

  const factory SnackMsg.fcmPermissionDenied() = _SnackMsgFcmPermissionDenied;

  const factory SnackMsg.reviewDeleted() = _SnackMsgReviewDeleted;

  const SnackMsg._();

  @override
  String get value => when(
        unknown: () => Strings.SNACK_ERR,
        noMoreItem: () => Strings.SNACK_NO_MORE_ITEM,
        cantOpenUrl: () => Strings.SNACK_CANT_OPEN_URL,
        urlCopied: () => Strings.SNACK_URL_COPIED,
        networkTimeout: () => Strings.ERR_NETWORK_TIMEOUT,
        networkDisconnected: () => Strings.ERR_NETWORK_DISCONNECTED,
        fcmUnsubscribe: () => Strings.SNACK_FCM_UNSUBSCRIBE,
        fcmSubscribe: () => Strings.SNACK_FCM_SUBSCRIBE,
        loginInputInvalid: () => Strings.SNACK_ERR_INVALID_AUTH_INPUT,
        fcmPermissionDenied: () => Strings.SNACK_ERR_FCM_PERMISSION,
        reviewDeleted: () => Strings.SNACK_ACTION_DELETE_REVIEW,
      );
}
