/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsPngGen {
  const $AssetsPngGen();

  AssetGenImage get badgeAmazonStore =>
      const AssetGenImage('assets/png/badge_amazon_store.png');
  AssetGenImage get logoGitGuardian =>
      const AssetGenImage('assets/png/logo_git_guardian.png');
  AssetGenImage get logoGithubActions =>
      const AssetGenImage('assets/png/logo_github_actions.png');
  AssetGenImage get sample => const AssetGenImage('assets/png/sample.png');
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  SvgGenImage get badgeAmazonStore =>
      const SvgGenImage('assets/svg/badge_amazon_store.svg');
  SvgGenImage get badgeAppStore =>
      const SvgGenImage('assets/svg/badge_app_store.svg');
  SvgGenImage get badgeGooglePlay =>
      const SvgGenImage('assets/svg/badge_google_play.svg');
  SvgGenImage get logoAlgolia =>
      const SvgGenImage('assets/svg/logo_algolia.svg');
  SvgGenImage get logoAnalytics =>
      const SvgGenImage('assets/svg/logo_analytics.svg');
  SvgGenImage get logoCrashlytics =>
      const SvgGenImage('assets/svg/logo_crashlytics.svg');
  SvgGenImage get logoDart => const SvgGenImage('assets/svg/logo_dart.svg');
  SvgGenImage get logoFastlane =>
      const SvgGenImage('assets/svg/logo_fastlane.svg');
  SvgGenImage get logoFigma => const SvgGenImage('assets/svg/logo_figma.svg');
  SvgGenImage get logoFlutter =>
      const SvgGenImage('assets/svg/logo_flutter.svg');
  SvgGenImage get logoGraphql =>
      const SvgGenImage('assets/svg/logo_graphql.svg');
  SvgGenImage get logoHosting =>
      const SvgGenImage('assets/svg/logo_hosting.svg');
  SvgGenImage get logoJira => const SvgGenImage('assets/svg/logo_jira.svg');
  SvgGenImage get logoKotlin => const SvgGenImage('assets/svg/logo_kotlin.svg');
  SvgGenImage get logoPerformance =>
      const SvgGenImage('assets/svg/logo_performance.svg');
  SvgGenImage get logoPostman =>
      const SvgGenImage('assets/svg/logo_postman.svg');
  SvgGenImage get logoSentry => const SvgGenImage('assets/svg/logo_sentry.svg');
  SvgGenImage get logoSwift => const SvgGenImage('assets/svg/logo_swift.svg');
  SvgGenImage get undrawAudio =>
      const SvgGenImage('assets/svg/undraw_audio.svg');
  SvgGenImage get undrawOnlinePayments =>
      const SvgGenImage('assets/svg/undraw_online_payments.svg');
  SvgGenImage get undrawSearch =>
      const SvgGenImage('assets/svg/undraw_search.svg');
}

class Assets {
  Assets._();

  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
