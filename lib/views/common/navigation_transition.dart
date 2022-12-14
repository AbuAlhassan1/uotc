import 'package:flutter/material.dart';

Route createRoute(child, settings, {required Offset begin, required Offset end}){
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvetween = CurveTween(curve: Curves.easeInOutCubicEmphasized);
      final tween = Tween<Offset>(begin: begin, end: end).chain(curvetween);
      final slideAnimation = animation.drive(tween);
      return SlideTransition(
        position: slideAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
    settings: settings
  );
}