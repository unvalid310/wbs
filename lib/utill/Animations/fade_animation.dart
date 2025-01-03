// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _AniProps { opacity, translate }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final String? direction;
  final double? directStart;

  const FadeAnimation({super.key, 
    required this.delay,
    required this.child,
    this.direction,
    this.directStart,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(
        _AniProps.opacity,
        Tween(begin: 0.0, end: 1.0),
        const Duration(milliseconds: 500),
      );

    if (direction != '' && direction != null) {
      tween
        .add(
          _AniProps.translate,
          Tween(begin: directStart, end: 0.0),
          const Duration(milliseconds: 500),
          Curves.easeOut,
        );
    }

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      tween: tween,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value.get(_AniProps.opacity),
          child: (direction != '' && direction != null)
              ? Transform.translate(
                  offset:
                      (direction == 'Horizontal' || direction == 'horizontal')
                          ? Offset(value.get(_AniProps.translate), 0)
                          : Offset(0, value.get(_AniProps.translate)),
                  child: child,
                )
              : child,
        );
      },
    );
  }
}
