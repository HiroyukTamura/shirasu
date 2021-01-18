// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seek_btn.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class SeekBtn extends StatelessWidget {
  const SeekBtn({Key key, @required this.lr, @required this.onTap})
      : super(key: key);

  final Lr lr;

  final void Function() onTap;

  @override
  Widget build(BuildContext _context) =>
      seekBtn(_context, lr: lr, onTap: onTap);
}

class _SeekIcon extends HookWidget {
  const _SeekIcon({Key key, this.lr}) : super(key: key);

  final Lr lr;

  @override
  Widget build(BuildContext _context) => _seekIcon(lr: lr);
}
