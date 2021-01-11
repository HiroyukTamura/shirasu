import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/resource/dimens.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shirasu/screen_detail/screen_detail/player_seekbar.dart';
import 'package:shirasu/viewmodel/viewmodel_video.dart';

class PlayerControllerView extends HookWidget {
  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: PlayerAnimOpacity(
          child: GestureDetector(
            onTap: () => _onTapBackDrop(context),
            child: ColoredBox(
              color: Colors.black.withOpacity(.5),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //todo implement
                      Visibility(
                        visible: false,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(MdiIcons.playSpeed),
                          onPressed: _onTapPlaySpeedBtn,
                        ),
                      ),
                      //todo implement
                      Visibility(
                        visible: false,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.video_settings),
                          onPressed: _onTapResolutionBtn,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.fullscreen),
                        onPressed: _onTapFullScreenBtn,
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      children: [
                        _SeekBtn(
                          icon: Icons.replay_30,
                          onTap: _onTapRewindBtn,
                        ),
                        Expanded(
                          child: IconButton(
                            iconSize: Dimens.VIDEO_PLAY_BTN_ICON_SIZE,
                            color: Colors.white,
                            icon: const Icon(
                              Icons.play_arrow,
                            ),
                            onPressed: _onTapPlayToggleBtn,
                          ),
                        ),
                        _SeekBtn(
                          icon: Icons.forward_30,
                          onTap: _onTapFastForwardBtn,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _onTapPlayToggleBtn() {}

  void _onTapFastForwardBtn() {}

  void _onTapRewindBtn() {}

  void _onTapFullScreenBtn() {}

  void _onTapResolutionBtn() {}

  void _onTapPlaySpeedBtn() {}

  void _onTapBackDrop(BuildContext context) =>
      context.read(pVideoViewModel).toggleVisibility();
}

class _SeekBtn extends StatelessWidget {
  const _SeekBtn({
    Key key,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Expanded(
        child: IconButton(
          color: Colors.white,
          iconSize: Dimens.VIDEO_SEEK_BTN_ICON_SIZE,
          icon: Icon(icon),
          onPressed: onTap,
        ),
      );
}
