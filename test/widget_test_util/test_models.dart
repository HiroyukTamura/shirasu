import 'package:shirasu/model/graphql/featured_programs_data.dart';
import 'package:shirasu/model/graphql/list_subscribed_programs.dart';
import 'package:shirasu/model/graphql/new_programs_data.dart';
import 'package:shirasu/model/graphql/watch_history_data.dart';
import 'package:shirasu/model/graphql/viewer.dart' hide ViewerUser;

class TestModels {
  const TestModels._();

  static const EMPTY_BROAD_CASTINGS = Broadcastings(
    typename: 'SearchableProgramConnection',
    rawItems: [],
  );

  static const EMPTY_NEW_PROGRAMS = NewProgramsData(
    newPrograms: NewPrograms(
      rawItems: [],
      typename: 'SearchableProgramConnection',
    ),
  );

  static const EMPTY_CHANNEL = Channels(
    rawItems: [],
    typename: 'ModelChannelConnection',
  );

  static const EMPTY_LIST_SUBSCRIBED_PROGRAMS = ListSubscribedPrograms(
    viewerUser: ViewerUser(
      subscribedPrograms:
          ProgramCollection(rawItems: [], typename: 'ProgramCollection'),
      id: 'DUMMY_ID',
      typename: 'User',
    ),
  );

  static const FEATURE_PROGRAM_DATA = FeatureProgramData(
    nowBroadcastings: EMPTY_BROAD_CASTINGS,
    comingBroadcastings: EMPTY_BROAD_CASTINGS,
    channels: EMPTY_CHANNEL,
  );

  static const EMPTY_WATCH_HISTORIES_DATA = WatchHistoriesData(
    viewerUser: ViewerUserSimple(
      watchHistories: WatchHistories(
        rawItems: [],
        typename: 'ModelWatchHistoryConnection',
      ),
      typename: 'User',
    ),
  );
}
