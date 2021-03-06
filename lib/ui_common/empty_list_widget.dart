import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/resource/font_size.dart';
import 'package:shirasu/ui_common/page_error.dart';

part 'empty_list_widget.g.dart';

/// @see [PageError]
@swidget
Widget emptyListWidget({
  @required String text,
  @required IconData icon,
}) =>
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 60,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: FontSize.S18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
