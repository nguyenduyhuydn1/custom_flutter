import 'dart:async';
// import 'package:flutter/material.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(Function action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(delay, () => action());
  }

  void dispose() => _timer?.cancel();

  // call(Function action) {
  //   _timer?.cancel();
  //   _timer = Timer(delay, () => action());
  // }
}
