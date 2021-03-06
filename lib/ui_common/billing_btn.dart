import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/model/graphql/channel_data.dart';
import 'package:shirasu/model/graphql/channel_subscription_plan.dart' as s;
import 'package:shirasu/resource/dimens.dart';
import 'package:shirasu/resource/strings.dart';
import 'package:shirasu/resource/text_styles.dart';
import 'package:shirasu/ui_common/ui_util.dart';

part 'billing_btn.g.dart';

// class BillingBtn extends StatelessWidget {
//   const BillingBtn({Key key, @required this.text}) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.deepOrange),
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.play_arrow_sharp,
//                 color: Colors.white,
//               ),
//               SizedBox(width: 16),
//               Text(
//                 text,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }

// class BillingBtnThin extends StatelessWidget {
//   const BillingBtnThin({Key key, @required this.text}) : super(key: key);
//
//   final String text;
//
//   @override
//   Widget build(BuildContext context) => Expanded(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.deepOrange),
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.play_arrow_sharp,
//                 color: Colors.white,
//               ),
//               SizedBox(width: 16),
//               Text(
//                 text,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
// }

/// note; only for monthly purchase.
/// [SubscriptionPlan]
/// but [s.SubscriptionPlan] has `interval` and `intervalCount`.
/// we need watch updating of the api response json structure.
@swidget
Widget billingBtnMedium({
  @required int amountWithTax,
  @required String currencyAsSuffix,
  @required GestureTapCallback onTap,
}) =>
    _ButtonMedium(
      onTap: onTap,
      icon: const Icon(
        Icons.play_arrow_sharp,
        color: Colors.white,
      ),
      text:
          '${Strings.MONTHLY}$amountWithTax$currencyAsSuffix${Strings.SUBSCRIBE_SUFFIX}',
    );

@swidget
Widget purchasedBannerMedium(
  BuildContext context, {
  @required GestureTapCallback onTap,
}) =>
    _ButtonMedium(
      onTap: onTap,
      icon: Icon(
        Icons.check_circle,
        color: Theme.of(context).primaryColor,
      ),
      text: Strings.SUBSCRIBED,
    );

@swidget
Widget _buttonMedium(
  BuildContext context, {
  @required GestureTapCallback onTap,
  @required Icon icon,
  @required String text,
}) =>
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.MARGIN_OUTLINE,
          vertical: 8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: kCircleBorderRadius,
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      icon: icon,
      onPressed: onTap,
      label: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          height: TextHeight.TEXT_H_SINGLE,
        ),
      ),
    );
