import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/screen_detail/page_base/item_base.dart';

part 'item_heading.g.dart';

@swidget
Widget itemHeading(BuildContext context, {
  @required String text,
  @required VoidCallback onClearClicked,
}) => Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ItemPadding(
          child: Text(
            text,
            style: TextStyle(
              height: 1,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        RawMaterialButton(
          onPressed: onClearClicked,
          elevation: 0,
          constraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          shape: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );