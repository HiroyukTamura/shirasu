import 'package:better_player/better_player.dart';
import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/styles.dart';
import 'package:shirasu/screen_detail/screen_detail/player_seekbar.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/row_bottom.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/row_center/drag_overlay.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/row_center/row_center.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/row_center/seek_btn.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/video_controller_vis.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/viewmodel/viewmodel_video.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/row_top.dart';
import 'package:shirasu/extension.dart';

// part 'player_controller_view.g.dart';

final kPrvDragStartDx = StateProvider.autoDispose<double>((ref) => 0);

final _kSPrvDoubleTapEvent =
    StateProvider.autoDispose.family<int, Lr>((ref, lr) => 0);

final _kPrvDoubleTapEvent = Provider.autoDispose
    .family<int, Lr>((ref, lr) => ref.watch(_kSPrvDoubleTapEvent(lr)).state);

class PlayerControllerView extends HookWidget {
  const PlayerControllerView({
    @required this.conf,
  });

  final VideoViewModelConf conf;

  static const _SEEK_ICON_SIZE = Size.square(48);
  static const double _FULLSCREEN_PADDING = 24;

  static double getFullScreenPadding(bool fullscreen) =>
      fullscreen ? _FULLSCREEN_PADDING : 0;

  @override
  Widget build(BuildContext context) => VideoControllerVis(
      conf: conf,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _onTapBgBtn(context),
        onDoubleTap: () {
          // for not fire onTap event
        },
        child: Stack(
          children: [
            DoubleTapPlayerView(
              doubleTapConfig: DoubleTapConfig.create(
                ovalColor: Styles.COLOR_DOUBLE_TAP_BG,
                rippleColor: Styles.COLOR_DOUBLE_TAP_BG,
                labelBuilder: _buildTapLabel,
                onDoubleTap: (lr) => _onDoubleTap(context, lr),
                iconLeft: _seekIcon(lr: Lr.LEFT),
                iconRight: _seekIcon(lr: Lr.RIGHT),
                expansionHoldingTime: const Duration(milliseconds: 400),
              ),
              swipeConfig: SwipeConfig.create(
                onSwipeStart: (dx) => _clearStartDx(context, dx),
                onSwipeCancel: () => _clearStartDx(context, 0),
                onSwipeEnd: (data) => _onSwipeEnd(context, data),
                overlayBuilder: _dragOverlay,
              ),
            ),
            PlayerAnimOpacity(
              conf: conf,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getFullScreenPadding(conf.fullScreen),
                ),
                color: Colors.black.withOpacity(.5),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    RowTop(
                      onTapFullScreenBtn: (context) =>
                          _onTapFullScreenBtn(context),
                      conf: conf,
                    ),
                    RowCenter(
                      conf: conf,
                      onTapRewindBtn: (context) => _onTapRewindBtn(context),
                      onTapFastForwardBtn: (context) =>
                          _onTapFastForwardBtn(context),
                      onTapPlayToggleBtn: (context) =>
                          _onTapPlayToggleBtn(context),
                    ),
                    RowBottom(
                      conf: conf,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  Future<void> _onTapPlayToggleBtn(BuildContext context) async =>
      context.read(pVideoViewModel(conf)).playOrPause();

  Future<void> _onTapFastForwardBtn(BuildContext context) async =>
      _seek(context, VideoViewModel.SEC_FAST_SEEK_BY_BTN);

  Future<void> _onTapRewindBtn(BuildContext context) async =>
      _seek(context, -VideoViewModel.SEC_FAST_SEEK_BY_BTN);

  Future<void> _seek(BuildContext context, Duration diff) async =>
      context.read(pVideoViewModel(conf)).seek(diff);

  Future<void> _onTapFullScreenBtn(BuildContext context) async =>
      context.toggleFullScreenMode();

  void _onTapBgBtn(BuildContext context) =>
      context.read(pVideoViewModel(conf)).toggleVisibility();

  void _onDoubleTap(BuildContext context, Lr lr) {
    context.read(pVideoViewModel(conf)).hide();
    context.read(_kSPrvDoubleTapEvent(lr)).state++;

    final duration = lr == Lr.LEFT
        ? -VideoViewModel.SEC_FAST_SEEK_BY_DOUBLE_TAP
        : VideoViewModel.SEC_FAST_SEEK_BY_DOUBLE_TAP;
    _seek(context, duration);
  }

  void _onSwipeEnd(BuildContext context, SwipeData data) {
    context.read(pVideoViewModel(conf)).seek(data.diffDuration);
    _clearStartDx(context, 0);
    context.read(pVideoViewModel(conf)).hide();
  }

  void _clearStartDx(BuildContext context, double dx) =>
      context.read(kPrvDragStartDx).state = dx;

  String _buildTapLabel(Lr lr, int tapCount) {
    final swapSec =
        tapCount * VideoViewModel.SEC_FAST_SEEK_BY_DOUBLE_TAP.inSeconds;
    return '$swapSec${Strings.TIME_UNIT_SEC}';
  }

  Widget _dragOverlay(SwipeData data) => DragOverlay(
        conf: conf,
        data: data,
      );

  Widget _seekIcon({@required Lr lr}) => SizedBox.fromSize(
        size: _SEEK_ICON_SIZE,
        child: SeekIcon<int>(
          lr: lr,
          provider: _kPrvDoubleTapEvent(lr),
        ),
      );
}
