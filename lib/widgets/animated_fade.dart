import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedFade extends StatelessWidget {
  final Widget child;

  const AnimatedFade({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child.animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }
}
