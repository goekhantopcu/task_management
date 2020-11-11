import 'package:flutter/cupertino.dart';

class NotGlowingListView extends StatelessWidget {
  final ListView content;

  const NotGlowingListView({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return null;
      },
      child: content,
    );
  }
}
