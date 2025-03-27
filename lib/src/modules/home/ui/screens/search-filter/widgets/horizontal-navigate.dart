import 'dart:ui';

import 'package:flutter/cupertino.dart';

Route createHorizontalPageRoute(Widget page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1, 0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Adding a scale effect for extra smoothness
        var scaleAnimation =
            Tween<double>(begin: 0.95, end: 1.0).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 400));
}
