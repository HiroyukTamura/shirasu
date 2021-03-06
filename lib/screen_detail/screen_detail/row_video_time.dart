import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/screen_detail/screen_detail/padding_row.dart';
import 'package:dartx/dartx.dart';
import 'package:shirasu/extension.dart';

class RowVideoTime extends StatelessWidget {
  RowVideoTime({
    @required this.broadcastAt,
    @required this.totalPlayTime,
    Key key,
  }) : _text = _genText(broadcastAt, totalPlayTime),
        super(key: key);

  final DateTime broadcastAt;
  final int totalPlayTime;
  final String _text;

  @override
  Widget build(BuildContext context) => basePadding(
        top: 4,
        child: Text(
          _text,
          style: TextStyles.videoTag,
        ),
      );

  /// todo need logic for the video has ended or not
  /// [mainTime] must be positive.
  static String _genText(DateTime broadcastAt, int mainTime) {
    final startStr = broadcastAt.formatLocalYmdHm();
    final endTime = broadcastAt.toLocal() + mainTime.seconds;
    final endStr = DateFormat('HH:mm').format(endTime);
    var text =
        '$startStr${Strings.TIME_PREFIX_START} $endStr${Strings.TIME_PREFIX_END}';
    if (endTime.isAfter(DateTime.now())) text += Strings.TIME_PREFIX_PLANNING;
    return text;
  }
}
