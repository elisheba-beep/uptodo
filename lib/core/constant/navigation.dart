import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  NavigatorState get _navigator => Navigator.of(this);

  void pushTo(Widget screen) =>
      _navigator.push(MaterialPageRoute(builder: (_) => screen));
}
