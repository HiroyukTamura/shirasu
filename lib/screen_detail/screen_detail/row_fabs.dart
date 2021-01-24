import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/di/url_util.dart';
import 'package:shirasu/dialog/btm_sheet_sns_share.dart';
import 'package:shirasu/model/graphql/detail_program_data.dart';
import 'package:shirasu/screen_detail/screen_detail/padding_row.dart';
import 'package:shirasu/screen_detail/screen_detail/screen_detail.dart';
import 'package:shirasu/screen_main/screen_main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/viewmodel/model/model_detail.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'row_fabs.g.dart';

class RowFabs extends StatelessWidget {
  const RowFabs({
    @required this.program,
    Key key,
  }) : super(key: key);

  static const double _PADDING_V = 36;
  final ProgramDetail program;

  /// todo implement
  @override
  Widget build(BuildContext context) => basePadding(
        top: _PADDING_V,
        bottom: _PADDING_V,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const _Fab(icon: Icons.comment),
            _Fab(
              icon: Icons.credit_card,
              onPressed: () => _onClickPaymentBtn(context),
            ),
            if (program.handouts.items.isNotEmpty)
              _Fab(icon: Icons.text_snippet,
                onPressed: () => _onClickHandoutsBtn(context),),
            const _Fab(icon: Icons.alarm_add),
            _Fab(
              icon: Icons.share,
              onPressed: () => _onClickShareBtn(context),
            ),
          ],
        ),
      );

  Future<void> _onClickShareBtn(BuildContext context) async =>
      showModalBottomSheet<void>(
        context: context.read(pDetailScaffold).key?.currentContext,
        builder: (context) => BtmSheetSnsShare(
          url: UrlUtil.programId2Url(program.id),
          urlTwitter: UrlUtil.programId2TwitterUrl(program.title, program.id)
              .toString(),
          urlFaceBook: UrlUtil.programId2FaceBookUrl(program.id).toString(),
        ),
      );

  Future<void> _onClickPaymentBtn(BuildContext context) async =>
      context.read(detailSNProvider(program.id)).togglePage(const PageSheetModel.pricing());

  Future<void> _onClickHandoutsBtn(BuildContext context) async =>
      context.read(detailSNProvider(program.id)).togglePage(const PageSheetModel.handouts());
}

@swidget
Widget _fab({
  IconData icon,
  VoidCallback onPressed,
}) =>
    RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      constraints: const BoxConstraints(
        minWidth: 54,
        minHeight: 36,
      ),
      fillColor: Colors.white.withOpacity(.8),
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
      ),
    );