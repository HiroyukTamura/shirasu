import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shirasu/gen/assets.gen.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/util/types.dart';
import 'package:shirasu/screen_detail/screen_detail/screen_detail.dart';
import 'package:dartx/dartx.dart';

part 'play_or_pause_icon.g.dart';

final _kPrvIsPlaying = Provider.autoDispose.family<bool, String>(
    (ref, id) => ref.watch(kPrvViewModelDetail(id).state).playOutState.isPlaying);

@hwidget
Widget _playOrPauseIcon({
  @required String id,
}) {
  final ac = useAnimationController(
    duration: 300.milliseconds,
    upperBound: .3,
  );
  return ProviderListener<bool>(
    provider: _kPrvIsPlaying(id),
    onChange: (context, isPlaying) => isPlaying ? ac.forward() : ac.reverse(),
    child: ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
      child: Lottie.asset(
        Assets.lottie.pausePlay,
        controller: ac,
      ),
    ),
  );
}

@hwidget
Widget playOrPauseBtn(
  BuildContext context, {
  @required OnTap onTap,
  @required String id,
}) {
  final isBuffering = useProvider(
      kPrvViewModelDetail(id).state.select((it) => it.playOutState.isBuffering));
  return Container(
    width: Dimens.VIDEO_PLAY_PAUSE_BTN_W,
    alignment: Alignment.center,
    child: Visibility(
      visible: !isBuffering,
      maintainState: true,//for animation
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: IconButton(
          padding: const EdgeInsets.all(20),
          iconSize: Dimens.VIDEO_PLAY_BTN_ICON_SIZE,
          color: Colors.white,
          icon: _PlayOrPauseIcon(id: id),
          onPressed: () => onTap(context),
        ),
      ),
    ),
  );
}
