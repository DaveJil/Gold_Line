import 'dart:async';
import 'package:flutter/material.dart';

class Stoppable {
  bool _stop = false;

  void stop() {
    _stop = true;
  }

  bool get isStopped => _stop;

  static BuildContext? currentContext;

  static void init(BuildContext context) {
    currentContext = context;
  }

  static void dispose() {
    currentContext = null;
  }

  Future<void> run(FutureOr<void> Function() callback) async {
    while (!_stop) {
      await callback();
    }
  }
}