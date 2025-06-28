import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void pushTo(String routeName, {Object? extra}) {
    push(routeName, extra: extra);
  }

  void pushWithReplacement(String routeName) {
    pushReplacement(routeName);
  }

  void pushToPase(String routeName) {
    go(routeName);
  }
}
