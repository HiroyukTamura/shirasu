import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/src/framework.dart';
import 'package:shirasu/di/api_client.dart';
import 'package:shirasu/di/network_image_client.dart';
import 'package:shirasu/main.dart';
import 'package:shirasu/viewmodel/model/dashboard_model.dart';
import 'package:shirasu/util.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/viewmodel/viewmodel_base.dart';

class ViewModelDashBoard extends ViewModelBaseChangeNotifier with MutableState {
  ViewModelDashBoard(this._ref) : super();

  final _apiClient = ApiClient.instance();
  final AutoDisposeProviderReference _ref;

  double headerBackDropScrollPos = 0;

  SnackBarMessageNotifier get _msgNotifier => _ref.read(snackBarMsgProvider);

  @override
  Future<void> initialize() async {
    if (!(state.state is StatePreInitialized)) return;

    DashboardModel newModel;

    try {
      final apiResult = await Util.wait2(_apiClient.queryFeaturedProgramsList,
          _apiClient.queryNewProgramsList);
      final data = ApiData(
        featureProgramData: apiResult.item1,
        newProgramsDataList: [apiResult.item2],
      );
      newModel = state.copyAsSuccess(data);
    } catch (e) {
      print(e);
      newModel = DashboardModel.error();
    }

    trySetState(newModel);

    try {
      final headerImage =
          await NetworkImageClient.instance.requestHeaderImage();
      trySetHeaderImage(headerImage);
    } catch (e) {
      // todo handle error
      print(e);
    }
  }

  Future<void> loadMoreNewPrg() async {
    final oldState = state;
    if (oldState.state is StateSuccess) {
      final nextToken =
          oldState.apiData.newProgramsDataList?.last?.newPrograms?.nextToken;
      if (nextToken == null) return;

      try {
        state = oldState.copyAsLoadMore();

        final newProgramsData = await _apiClient.queryNewProgramsList(
          nextToken: nextToken,
        );

        oldState.apiData.newProgramsDataList.add(newProgramsData);
        trySetState(oldState.copyAsSuccess(oldState.apiData));

        if (newProgramsData.newPrograms.items.isEmpty)
          _msgNotifier.notifyMsg(SnackMsg.NO_MORE_ITEM, false);
      } catch (e) {
        debugPrint(e.toString());
        trySetState(DashboardModel.error());
        _msgNotifier.notifyMsg(SnackMsg.UNKNOWN, false);
      }
    }
  }

  void updateScrollOffset(double offset) {
    final s = state;
    if (s.state is StateSuccess && isMounted)
      state = s.copyWith(offset: offset);
  }

  void updateBillboardHeaderPage(int page) {
    final s = state;
    if (s.state is StateSuccess && isMounted)
      state = s.copyWith(billboardHeaderPage: page);
  }

  void updateChannelOffset(double offset) {
    final s = state;
    if (s.state is StateSuccess && isMounted)
      state = s.copyWith(channelHorizontalOffset: offset);
  }

  void updateSubscribingCarouselOffset(double offset) {
    final s = state;
    if (s.state is StateSuccess && isMounted)
      state = s.copyWith(subscribingChannelOffset: offset);
  }
}
