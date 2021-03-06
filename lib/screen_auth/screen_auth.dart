import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:shirasu/repository/env_repository.dart';
import 'package:shirasu/screen_auth/screen_auth_scratch.dart';
import 'package:shirasu/screen_auth/screen_auth_webview.dart';

part 'screen_auth.g.dart';

@hwidget
Widget screenAuth() => EnvRepositoryImpl.useScratchAuth
    ? const ScreenAuthScratch()
    : const ScreenAuthWebView();
