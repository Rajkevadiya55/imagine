import 'package:flutter/material.dart';
import 'package:imagine/widget/common_text.dart';
import 'dart:math' as math;

class FadingCircleLoader extends StatefulWidget {
  const FadingCircleLoader({super.key});

  @override
  _FadingCircleLoaderState createState() => _FadingCircleLoaderState();
}

class _FadingCircleLoaderState extends State<FadingCircleLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Continuously repeat the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 33.0,
            height: 33.0,
            child: CustomPaint(
              painter: FadingCirclePainter(_controller),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          const CustomText(
            text: 'Please wait..',
            color: Colors.black,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}

class FadingCirclePainter extends CustomPainter {
  final Animation<double> animation;
  final int circleCount = 12; // Number of circles

  FadingCirclePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint paint = Paint()..color = Colors.grey;

    for (int i = 0; i < circleCount; i++) {
      final double progress = (i + 1) / circleCount;
      final double opacity = (animation.value - progress).abs() < 0.25
          ? 1.0
          : 0.25; // Circles fade in and out
      paint.color = Colors.grey.withOpacity(opacity);

      final double angle = 2 * math.pi * (i / circleCount);
      final double dx = radius + radius * math.cos(angle);
      final double dy = radius + radius * math.sin(angle);
      canvas.drawCircle(
          Offset(dx, dy), size.width * 0.08, paint); // Draw circle
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
