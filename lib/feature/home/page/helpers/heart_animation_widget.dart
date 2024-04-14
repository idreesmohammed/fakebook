import 'package:flutter/material.dart';

class HeartAnimationwidget extends StatefulWidget {
  const HeartAnimationwidget(
      {super.key,
      required this.child,
      required this.isAnimation,
      required this.time,
      this.onEnd});
  final Widget child;
  final bool isAnimation;
  final Duration time;
  final VoidCallback? onEnd;

  @override
  State<HeartAnimationwidget> createState() => _HeartAnimationwidgetState();
}

class _HeartAnimationwidgetState extends State<HeartAnimationwidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  @override
  void initState() {
    final durationHalf = widget.time.inMilliseconds ~/ 2;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: durationHalf));
    scale = Tween<double>(begin: 1, end: 1.2).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HeartAnimationwidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimation != oldWidget.isAnimation) {
      animate();
    }
  }

  Future animate() async {
    await animationController.forward();
    await animationController.reverse();
    Future.delayed(const Duration(milliseconds: 400));
    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
