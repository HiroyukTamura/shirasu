import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shirasu/di/api_client.dart';
import 'package:shirasu/di/dio_client.dart';
import 'package:shirasu/di/hive_client.dart';
import 'package:shirasu/di/url_util.dart';
import 'package:shirasu/main.dart';
import 'package:shirasu/model/graphql/channel_data.dart';
import 'package:shirasu/model/graphql/detail_program_data.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/viewmodel/model/model_detail.dart';
import 'package:shirasu/viewmodel/viewmodel_base.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ViewModelDetail extends ViewModelBase<ModelDetail> {
  ViewModelDetail(this.id, this._ref)
      : channelId = UrlUtil.programId2channelId(id),
        super(ModelDetail.initial());

  final _apiClient = ApiClient.instance();
  final _dioClient = DioClient();
  final panelController = PanelController();
  final AutoDisposeProviderReference _ref;
  final String id;
  final String channelId;

  DetailPrgItem get _previewArchivedVideoData {
    final v = state.prgDataResult;
    if (v is StateSuccess)
      return v.programDetailData.program.previewPrgItem;
    else
      return null;
  }

  DetailPrgItem get _availableVideoData {
    final v = state.prgDataResult;
    if (v is StateSuccess) {
      final program = v.programDetailData.program;

      //todo shouldn't written in DetailProgramData?
      DetailPrgItem detailPrgItem; //todo more logic
      if (program.archivedAt?.isBefore(DateTime.now()) == true) {
        if (program.isAllExtensionAvailable)
          detailPrgItem = program.lastArchivedExtensionPrgItem;
        else {
          // todo implement
          throw UnimplementedError();
        }
      }

      return detailPrgItem ?? program.nowLivePrgItem;
    } else
      return null;
  }

  @override
  Future<void> initialize() async {
    if (state.prgDataResult is StateSuccess) return;

    state = state.copyWith(prgDataResult: const DetailModelState.loading());
    ModelDetail newState;
    try {
      final data = await Util.wait2<ProgramDetailData, ChannelData>(
          () async => _apiClient.queryProgramDetail(id),
          () async => _apiClient.queryChannelData(channelId));

      newState = state.copyWith(
        prgDataResult: DetailModelState.success(
          programDetailData: data.item1,
          channelData: data.item2,
          page: const PageSheetModel.hidden(),
        ),
      );
    } catch (e) {
      print(e);
      newState = state.copyWith(prgDataResult: const DetailModelState.error());
    }
    setState(newState);
  }

  Future<void> playVideo(bool preview) async {
    final prg = preview ? _previewArchivedVideoData : _availableVideoData;
    if (prg == null) return; // todo handle error

    state = state.copyAsInitialize(prg.urlAvailable, prg.videoTypeStrict);

    String cookie;
    try {
      cookie = await _dioClient.getSignedCookie(prg.id, prg.videoTypeStrict,
          HiveAuthClient.instance().authData.body.idToken);
      debugPrint(cookie);
    } catch (e) {
      print(e); //todo handle error
    }

    if (cookie != null && mounted)
      state = state.copyAsPlay(prg.urlAvailable, prg.videoTypeStrict, cookie);
  }

  Future<String> queryHandOutUrl(String handoutId) async {
    if (state.isHandoutUrlRequesting) return null;

    state = state.copyWith(isHandoutUrlRequesting: true);

    String url;
    try {
      url = await _apiClient.queryHandOutUrl(id, handoutId);
    } catch (e) {
      print(e);
    }

    if (!mounted) return null;

    if (url == null)
      _ref.read(snackBarMsgProvider).state = SnackMsg.UNKNOWN;
    else
      state = state.copyWith(isHandoutUrlRequesting: false);

    return url;
  }

  Future<void> togglePage(PageSheetModel pageSheet) async {
    final newOne = state.copyAsPageSheet(pageSheet);
    if (newOne == null) return;

    state = newOne;

    if (!panelController.isAttached) return;

    if (pageSheet == const PageSheetModel.hidden())
      await panelController.close();
    else
      await panelController.open();
  }

  Future<bool> tryClosePanel() async {
    if (!panelController.isAttached || panelController.isPanelClosed)
      return false;
    await panelController.close();
    return true;
  }

  /// force update [state.playOutState.fullScreen]
  void takePriorityAndSetTotalDuration({
    @required bool fullScreen,
    @required Duration totalDuration,
  }) {
    assert(!totalDuration.isNegative);

    state = state.copyWith.playOutState(
      totalDuration: totalDuration,
      fullScreen: fullScreen,
    );
  }

  void setCurrentPos({
    @required bool fullScreen,
    @required Duration currentPos,
  }) {
    assert(!currentPos.isNegative);

    if (fullScreen == state.playOutState.fullScreen)
      state = state.copyWith.playOutState(
        currentPos: currentPos,
        fullScreen: fullScreen,
      );
  }

  void setVideoDurations({
    @required bool fullScreen,
    @required Duration currentPos,
    @required Duration totalDuration,
  }) {
    assert(!currentPos.isNegative);
    assert(!totalDuration.isNegative);
    assert(currentPos < totalDuration);

    if (fullScreen == state.playOutState.fullScreen)
      state = state.copyWith.playOutState(
        currentPos: currentPos,
        totalDuration: totalDuration,
        fullScreen: fullScreen,
      );
  }

  void setVideoIsPlaying({
    @required bool fullScreen,
    @required bool isPlaying,
  }) {
    if (fullScreen == state.playOutState.fullScreen)
      state = state.copyWith.playOutState(
        isPlaying: isPlaying,
      );
  }
}
