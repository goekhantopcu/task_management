import 'package:flutter/cupertino.dart';
import 'package:task_management/notifier/group_controller.dart';

class GlobalState extends InheritedWidget {
  final GroupController _controller;

  GlobalState(
    this._controller, {
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static GroupController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GlobalState>()
        ._controller;
  }

  GroupController get categories => _controller;

  @override
  bool updateShouldNotify(GlobalState old) => _controller != old._controller;
}
