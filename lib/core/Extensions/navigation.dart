import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void pushTo(String routeName) {
    push(routeName);
  }

  void pushWithReplacement(String routeName) {
    pushReplacement(routeName);
  }

  void pushPase(String routeName) {
    go(routeName);
  }
}
