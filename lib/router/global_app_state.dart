import 'package:flutter/widgets.dart';
import 'package:shirasu/router/screen_main_route_path.dart';

// todo synchronize?
class GlobalAppState extends ChangeNotifier {
  GlobalAppState._();

  static final instance = GlobalAppState._();

  List<GlobalRoutePathBase> _list = [];

  GlobalRoutePathBase get last => list.last;

  PathDataMainPageBase get findLastMainPagePath =>
      list.firstWhere((it) => it is PathDataMainPageBase)
      as PathDataMainPageBase;

  // todo change to ImmutableListView
  List<GlobalRoutePathBase> get list {
    if (_list.isEmpty) _list.add(const PathDataMainPageBase.dashboard());
    return _list;
  }

  //todo fix
  void push(GlobalRoutePathBase path) {
    if (last == const GlobalRoutePath.auth() && path == const GlobalRoutePath.auth())
      return;

    if (last == const GlobalRoutePath.auth() && path == const GlobalRoutePath.error())
      _list.removeLast();

    if (last == const GlobalRoutePath.error() || last == const GlobalRoutePath.intro())
      _list.removeLast();

    if (last is PathDataMainPageBase && path is PathDataMainPageBase)
      _list.removeLast();

    _list.add(path);

    notifyListeners();
  }

  void pop() {
    if (_list.isEmpty) return;

    _list.removeLast();
    notifyListeners();
  }
}