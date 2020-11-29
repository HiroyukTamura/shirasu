import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:shirasu/di/api_client.dart';
import 'package:shirasu/model/featured_programs_data.dart';
import 'package:shirasu/model/watch_history_data.dart';
import 'package:shirasu/viewmodel/viewmodel_base.dart';
import 'package:shirasu/viewmodel/viewmodel_dashboard.dart' show ApiClientResult;

part 'viewmodel_subscribing.freezed.dart';


class ViewModelSubscribing extends DisposableValueNotifier<FeatureProgramState> with ViewModelBase {

  ViewModelSubscribing() : super(const FeatureProgramStatePreInitialized());

  final _apiClient = ApiClient(Client());

  @override
  Future<void> initialize() async {
    if (value is FeatureProgramStateSuccess || value is FeatureProgramStateLoading)
      return;

    try {
      final data = await _apiClient.queryFeaturedProgramsList();
      value = FeatureProgramStateSuccess(data);
    } catch (e) {
      print(e);
      value = const FeatureProgramStateError();
    }
  }
}

class ViewModelWatchHistory extends DisposableValueNotifier<WatchHistoryState> with ViewModelBase {

  ViewModelWatchHistory() : super(const StatePreInitialized());

  final _apiClient = ApiClient(Client());

  @override
  Future<void> initialize() async {
    if (value is StateSuccess || value is StateLoading)
      return;

    try {
      value = const StateLoading();
      final data = await _apiClient.queryWatchHistory();
      value = StateSuccess([data]);
    } catch (e) {
      print(e);
      value = const StateError();
    }

    notifyListeners();
  }


  Future<void> loadMoreWatchHistory() async {
    final oldState = value;
    if (oldState is StateSuccess) {
      final nextToken = oldState.watchHistories.last.viewerUser.watchHistories.nextToken;
      if (nextToken == null)
        return;

      value = StateLoadingMore(oldState.watchHistories);

      try {
        final newOne = await _apiClient.queryWatchHistory(
          nextToken: nextToken,
        );

        if (!isDisposed)
          return ApiClientResult.CANCELED;

        oldState.watchHistories.add(newOne);
        value = StateSuccess(oldState.watchHistories);

        if (newOne.viewerUser.watchHistories.items.isEmpty) {
          //todo show SnackBar
        }

        return;

      } catch (e) {
        debugPrint(e.toString());
        //todo show SnackBar
      }
    }
  }
}

@freezed
abstract class FeatureProgramState with _$FeatureProgramState {
  const factory FeatureProgramState.preInitialized() = FeatureProgramStatePreInitialized;
  const factory FeatureProgramState.loading() = FeatureProgramStateLoading;
  const factory FeatureProgramState.resultEmpty() = FeatureProgramStateResultEmpty;
  const factory FeatureProgramState.success(FeatureProgramData featureProgramData) = FeatureProgramStateSuccess;
  const factory FeatureProgramState.error() = FeatureProgramStateError;
}

@freezed
abstract class WatchHistoryState with _$WatchHistoryState {
  const factory WatchHistoryState.preInitialized() = StatePreInitialized;
  const factory WatchHistoryState.loading() = StateLoading;
  const factory WatchHistoryState.resultEmpty() = StateResultEmpty;
  const factory WatchHistoryState.success(List<WatchHistoriesData> watchHistories) = StateSuccess;
  const factory WatchHistoryState.loadingMore(List<WatchHistoriesData> watchHistories) = StateLoadingMore;
  const factory WatchHistoryState.error() = StateError;
}