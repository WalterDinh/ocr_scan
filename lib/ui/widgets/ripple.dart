import 'package:flutter/material.dart';
import 'package:my_app/core/values/app_values.dart';

class Ripple extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color rippleColor;
  final double rippleRadius;
  final Function(TapDownDetails)? onTapDown;

  const Ripple({
    Key? key,
    this.child,
    required this.onTap,
    this.rippleColor = const Color(0x0338686A),
    this.rippleRadius = AppValues.smallRadius,
    this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(rippleRadius),
        highlightColor: rippleColor,
        onTap: onTap,
        onTapDown: onTapDown,
        child: child,
      ),
    );
  }
}
