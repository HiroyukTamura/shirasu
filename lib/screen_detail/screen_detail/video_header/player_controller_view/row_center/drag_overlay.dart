import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/resource/font_size.dart';
import 'package:shirasu/screen_detail/screen_detail/screen_detail.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shirasu/extension.dart';
import 'package:shirasu/viewmodel/model/model_detail.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/screen_detail/screen_detail/video_header/player_controller_view/player_controller_view.dart';

// part 'drag_overlay.g.dart';

class DragOverlay extends HookWidget {
  const DragOverlay({
    @required this.conf,
    @required this.data,
    Key key,
  }) : super(key: key);

  final VideoViewModelConf conf;
  final SwipeData data;

  @override
  Widget build(BuildContext context) {
    useProvider(kPrvDragStartDx); //listen drag start fixme??

    var diffDuration = data.diffDuration;

    final videoPosWhenDragStart = useProvider(kPrvViewModelDetail(conf.id)
        .state
        .select((it) => it.playOutState.currentPosForUiSafe));
    final videoReady = useProvider(kPrvVideoControllerReady(conf.id));
    final totalDuration = useProvider(kPrvViewModelDetail(conf.id)
        .state
        .select((it) => it.playOutState.totalDurationSafe));
    if (!videoReady || videoPosWhenDragStart == Duration.zero)
      return const SizedBox.shrink();

    var aimingPos = videoPosWhenDragStart + diffDuration;
    if (totalDuration < aimingPos) {
      aimingPos = totalDuration;
      diffDuration = videoPosWhenDragStart - totalDuration;
    } else if (aimingPos < Duration.zero) {
      aimingPos = Duration.zero;
      diffDuration = -videoPosWhenDragStart;
    }

    final diffText = Util.formatDurationHHMM(diffDuration, true);
    final positionText = Util.formatDurationHHMM(aimingPos, false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            positionText,
            style: const TextStyle(
              fontSize: FontSize.S30,
            ),
          ),
          Text(
            diffText,
            style: const TextStyle(
              fontSize: FontSize.S20,
            ),
          ),
        ],
      ),
    );
  }
}
