import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeInAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeInAnimation({Key? key, required this.delay, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int millisecondsDelay = 500;
    final MovieTween tween = MovieTween()
      ..scene(
              begin: const Duration(milliseconds: 0),
              end: const Duration(milliseconds: 500))
          .tween('opacity', Tween(begin: 0.0, end: 1.0))
      ..scene(
              begin: const Duration(milliseconds: 0),
              end: const Duration(milliseconds: 500))
          .tween('translateY', Tween(begin: -30.0, end: 0.0));

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (millisecondsDelay * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get('opacity'),
        child: Transform.translate(
            offset: Offset(
              0,
              value.get('translateY'),
            ),
            child: child),
      ),
    );
  }
}
