import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/gen/assets.gen.dart';
import 'package:shirasu/resource/font_size.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/styles.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/ui_common/ui_util.dart';
import 'package:shirasu/util/types.dart';
import 'package:shirasu/extension.dart';

part 'page_error.g.dart';

class PageError extends StatelessWidget {
  const PageError({
    Key key,
    this.onTapLoginBtn,
    String text,
  })  : _text = text ?? Strings.SNACK_ERR,
        super(key: key);

  final OnTap onTapLoginBtn;
  final String _text;

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.isThinScreen ? 80 : 160;
    return SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.svg.roboto.svg(
                      color: Styles.COLOR_TEXT_SUB,
                      width: iconSize,
                      height: iconSize,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: FontSize.S16,
                        color: Styles.COLOR_TEXT_SUB,
                      ),
                    ),
                    if (onTapLoginBtn != null)
                      _LoginBtn(onTapLoginBtn: onTapLoginBtn),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

@swidget
Widget _loginBtn(
  BuildContext context, {
  @required OnTap onTapLoginBtn,
}) =>
    Container(
      padding: const EdgeInsets.only(top: 24),
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: kCircleBorderRadius,
          ),
          primary: Theme.of(context).primaryColor,
        ),
        onPressed: () => onTapLoginBtn(context),
        child: const Text(
          Strings.LOGIN_BTN_VALUE,
          maxLines: 1,
          style: TextStyle(
            fontSize: FontSize.S16,
            height: TextHeight.TEXT_H_SINGLE,
          ),
        ),
      ),
    );

/// replacement of [PageError] for small space
@swidget
Widget pageErrText({
  @required String text,
  Color backColor,
}) =>
    Container(
      color: backColor,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
          color: Styles.COLOR_TEXT_SUB,
        ),
      ),
    );

// return LayoutBuilder(
//   builder: (context, constrains) => SafeArea(
//     child: Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.all(48),
//       child:
//       Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         AspectRatio(
//           aspectRatio: Dimens.ERROR_WIDGET_RATIO,
//           child: Assets.svg.undrawWarningCyit.supportWeb().toWidget(),
//         ),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 16,
//           ),
//         ),
//       ]),
//     ),
//   ),
// );
