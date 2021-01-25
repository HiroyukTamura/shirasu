import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/di/hive_client.dart';
import 'package:shirasu/dialog/btm_sheet.dart';
import 'package:shirasu/dialog/portal_animated_modal_barrier.dart';
import 'package:shirasu/screen_detail/screen_detail/btm_sheet/common.dart';
import 'package:shirasu/screen_detail/screen_detail/screen_detail.dart';
import 'package:shirasu/util.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shirasu/viewmodel/model/model_detail.dart';

part 'btm_sheet_play_speed.g.dart';

@hwidget
Widget btmSheetPlaySpeed(
  BuildContext context, {
  @required String id,
  @required Widget child,
}) =>
    ListBtmSheet<double>(
      items: HivePrefectureClient.PLAY_SPEED,
      textBuilder: (speed) {
        final string = speed.truncate() == speed
            ? speed.toStringAsFixed(1)
            : speed.toString();
        return 'x$string';
      },
      visible: useProvider(detailSNProvider(id)
          .state
          .select((it) => it.portalState == const PortalState.playSpeed())),
      isSelected: (speed) {
        final currentSpeed = useProvider(kPrvHivePlaySpeedUpdate).data?.value ??
            HivePrefectureClient.instance().playSpeed;
        return speed == currentSpeed;
      },
      onTapBackDrop: () => context.read(detailSNProvider(id)).clearModal(),
      onTap: (speed) {
        context.read(detailSNProvider(id)).clearModal();
        HivePrefectureClient.instance().setPlaySpeed(speed);
      },
      child: child,
    );

@Deprecated('currently not implemented')
@hwidget
Widget btmSheetResolution(
  BuildContext context, {
  @required String id,
  @required Widget child,
}) =>
    ListBtmSheet<int>(
      items: HivePrefectureClient.RESOLUTIONS,
      textBuilder: (resolution) => 'x$resolution',
      visible: useProvider(detailSNProvider(id)
          .state
          .select((it) => it.portalState == const PortalState.resolution())),
      isSelected: (resolution) {
        final currentSpeed = useProvider(kPrvHiveResolutionUpdate).data?.value ??
            HivePrefectureClient.instance().resolution;
        return resolution == currentSpeed;
      },
      onTapBackDrop: () => context.read(detailSNProvider(id)).clearModal(),
      onTap: (resolution) {
        context.read(detailSNProvider(id)).clearModal();
        HivePrefectureClient.instance().setResolution(resolution);
      },
      child: child,
    );
