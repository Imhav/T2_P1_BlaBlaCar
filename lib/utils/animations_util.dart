import 'package:flutter/material.dart';

class AnimationUtils {
  // Animation duration in milliseconds
  static const int transitionSpeed = 500;

  ////
  /// Slide given screen from bottom to top
  ///
  static Route<T> createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0); // Start from the bottom of the screen
    const end = Offset(0.0, 0.0); // Move to the top of the screen
    return _createAnimatedRoute(screen, begin, end);
  }

  static Route<T> _createAnimatedRoute<T>(
      Widget screen, Offset begin, Offset end) {
    return PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: transitionSpeed),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
