import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:http/http.dart' show Client;
import 'package:shirasu/client/api_client.dart';
import 'package:shirasu/main.dart';
import 'package:shirasu/model/graphql/featured_programs_data.dart';
import 'package:shirasu/model/graphql/watch_history_data.dart';
import 'package:shirasu/viewmodel/message_notifier.dart';
import 'package:shirasu/viewmodel/viewmodel_base.dart';
import 'package:riverpod/src/framework.dart';
import 'package:shirasu/extension.dart';

part 'viewmodel_subscribing.freezed.dart';

//todo fix lint config as concerned to lack of generics
class ViewModelSubscribing extends ViewModelBase<FeatureProgramState> {
  ViewModelSubscribing() : super(const FeatureProgramStatePreInitialized());

  final _apiClient = ApiClient.instance();

  @override
  Future<void> initialize() async {
    if (!(state is FeatureProgramStatePreInitialized)) return;

    state = const FeatureProgramStatePreInitialized();

    FeatureProgramState newState;
    try {
      final data = await _apiClient.queryFeaturedProgramsList();
      newState = data.viewerUser.subscribedPrograms.isEmpty
          ? const FeatureProgramStateResultEmpty()
          : FeatureProgramStateSuccess(data);
    } catch (e) {
      print(e);
      newState = const FeatureProgramStateError();
    }
    setState(newState);
  }
}

class ViewModelWatchHistory extends ViewModelBase<WatchHistoryState> {
  ViewModelWatchHistory(this._ref) : super(const StatePreInitialized());

  final AutoDisposeProviderReference _ref;
  final _apiClient = ApiClient.instance();

  SnackBarMessageNotifier get _msgNotifier => _ref.read(snackBarMsgProvider);

  @override
  Future<void> initialize() async {
    if (!(state is StatePreInitialized)) return;

    state = const StateLoading();

    WatchHistoryState newState;

    try {
      final data = await _apiClient.queryWatchHistory();
      newState = data.viewerUser.watchHistories.items.isEmpty
          ? const StateResultEmpty()
          : StateSuccess([data].toUnmodifiable());
    } catch (e) {
      print(e);
      newState = const StateError();
    }

    setState(newState);
  }

  Future<void> loadMoreWatchHistory() async {
    final oldState = state;
    if (oldState is StateSuccess) {
      final nextToken =
          oldState.watchHistories.last.viewerUser.watchHistories.nextToken;
      if (nextToken == null) return;

      // we don't check if Disposed
      state = StateLoadingMore(oldState.watchHistories);

      try {
        final newOne = await _apiClient.queryWatchHistory(
          nextToken: nextToken,
        );

        oldState.watchHistories
            .add(newOne); //todo fix to watchHistories immutable collection
        setState(StateSuccess(oldState.watchHistories));

        if (newOne.viewerUser.watchHistories.items.isEmpty)
          _msgNotifier.notifyMsg(const SnackMsg.noMoreItem(), false);

        return;
      } catch (e) {
        setState(StateSuccess(oldState.watchHistories));
        debugPrint(e.toString());
        _msgNotifier.notifyMsg(const SnackMsg.unknown(), false);
      }
    }
  }
}

@freezed
abstract class FeatureProgramState with _$FeatureProgramState {
  const factory FeatureProgramState.preInitialized() =
      FeatureProgramStatePreInitialized;

  const factory FeatureProgramState.loading() = FeatureProgramStateLoading;

  const factory FeatureProgramState.resultEmpty() =
      FeatureProgramStateResultEmpty;

  const factory FeatureProgramState.success(
      FeatureProgramData featureProgramData) = FeatureProgramStateSuccess;

  const factory FeatureProgramState.error() = FeatureProgramStateError;
}

@freezed
abstract class WatchHistoryState with _$WatchHistoryState {
  const factory WatchHistoryState.preInitialized() = StatePreInitialized;

  const factory WatchHistoryState.loading() = StateLoading;

  const factory WatchHistoryState.resultEmpty() = StateResultEmpty;

  const factory WatchHistoryState.success(
      UnmodifiableListView<WatchHistoriesData> watchHistories) = StateSuccess;

  const factory WatchHistoryState.loadingMore(
      UnmodifiableListView<WatchHistoriesData> watchHistories) = StateLoadingMore;

  const factory WatchHistoryState.error() = StateError;
}
