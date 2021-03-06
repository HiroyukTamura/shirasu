import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/repository/logger_repository_impl.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/util/types.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/viewmodel/model/model_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'btm_sheet_sns_share.g.dart';

const double _kListTileHeight = 56;
const double _kPadV = 16;

@swidget
Widget btmSheetSnsShare({
  @required ShareUrl shareUrl,
  @required SnackCallback snackCallback,
}) =>
    BtmSheetListView(children: [
      if (shareUrl.urlTwitter != null)
        _TileTwitter(
          urlTwitter: shareUrl.urlTwitter,
          onUrlInvalid: () => snackCallback(const SnackMsg.cantOpenUrl()),
        ),
      if (shareUrl.urlFaceBook != null)
        _TileFacebook(
          urlFaceBook: shareUrl.urlFaceBook,
          onUrlInvalid: () => snackCallback(const SnackMsg.cantOpenUrl()),
        ),
      _TileUrl(
        url: shareUrl.url,
        snackCallback: snackCallback,
      )
    ]);

@swidget
Widget btmSheetListItem({
  @required IconData icon,
  @required String title,
  @required VoidCallback onTap,
}) =>
    ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 36),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: onTap,
    );

@swidget
Widget btmSheetListView({
  @required List<Widget> children,
}) =>
    SizedBox(
      height: _kListTileHeight * children.length + _kPadV * 2,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: _kPadV),
        children: children,
      ),
    );

@swidget
Widget _tileTwitter(
  BuildContext context, {
  @required String urlTwitter,
  @required VoidCallback onUrlInvalid,
}) =>
    BtmSheetListItem(
      onTap: () async {
        Navigator.of(context).pop();
        await Util.launchUrl(context, urlTwitter, onUrlInvalid);
      },
      title: Strings.SHARE_TWITTER,
      icon: FontAwesomeIcons.twitter,
    );

@swidget
Widget _tileFacebook(
  BuildContext context, {
  @required String urlFaceBook,
  @required VoidCallback onUrlInvalid,
}) =>
    BtmSheetListItem(
      onTap: () async {
        Navigator.of(context).pop();
        await Util.launchUrl(context, urlFaceBook, onUrlInvalid);
      },
      title: Strings.SHARE_FACEBOOK,
      icon: FontAwesomeIcons.facebook,
    );

@swidget
Widget _tileUrl(
  BuildContext context, {
  @required String url,
  @required SnackCallback snackCallback,
}) =>
    BtmSheetListItem(
      onTap: () async {
        final result = await context.read(kPrvLogger).guardFuture(
            () async => Clipboard.setData(ClipboardData(text: url)));
        Navigator.of(context).pop();
        final msg = result.when(
          success: (_) => const SnackMsg.urlCopied(),
          failure: (e) => const SnackMsg.unknown(),
        );
        snackCallback(msg);
      },
      title: Strings.COPY_URL,
      icon: Icons.copy,
    );
