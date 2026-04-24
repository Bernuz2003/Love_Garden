import 'package:flutter/material.dart';

class SkyWidget extends StatelessWidget {
  const SkyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final skyColors = _colorsForHour(hour);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Sky gradient
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: skyColors,
              ),
            ),
          ),

          // Each cloud is an independent widget with its own animation cycle
          const _SingleCloud(yFraction: 0.10, scale: 1.0, durationSeconds: 80, startFraction: 0.2),
          const _SingleCloud(yFraction: 0.30, scale: 0.7, durationSeconds: 110, startFraction: 0.6),
          const _SingleCloud(yFraction: 0.06, scale: 0.85, durationSeconds: 95, startFraction: 0.8),
          const _SingleCloud(yFraction: 0.45, scale: 0.6, durationSeconds: 130, startFraction: 0.1),
          const _SingleCloud(yFraction: 0.22, scale: 0.75, durationSeconds: 100, startFraction: 0.4),
        ],
      ),
    );
  }

  List<Color> _colorsForHour(int hour) {
    if (hour >= 6 && hour < 12) {
      return const [Color(0xFF87CEEB), Color(0xFFB6E3F4), Color(0xFFE0F4FF)];
    } else if (hour >= 12 && hour < 18) {
      return const [Color(0xFF5BACD8), Color(0xFF7EC8E3), Color(0xFFBBDEF0)];
    } else if (hour >= 18 && hour < 20) {
      return const [Color(0xFF3D2B56), Color(0xFFCF6679), Color(0xFFFFB88C)];
    } else {
      return const [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF2A4066)];
    }
  }
}

// ---------------------------------------------------------------------------
// _SingleCloud — one cloud that drifts from left to right independently.
//
// Movement cycle:
//   1. Starts off-screen to the LEFT (x = -cloudWidth)
//   2. Drifts smoothly to the RIGHT edge (x = screenWidth + extra)
//   3. Once fully off-screen right, jumps back to (x = -cloudWidth)
//      → the jump is invisible because the cloud is fully off-screen
//   4. Repeats forever
// ---------------------------------------------------------------------------
class _SingleCloud extends StatefulWidget {
  final double yFraction;   // vertical position as fraction of sky height
  final double scale;        // relative size of the cloud
  final int durationSeconds; // how long to cross the full screen
  final double startFraction;// random initial progress of the animation

  const _SingleCloud({
    Key? key,
    required this.yFraction,
    required this.scale,
    required this.durationSeconds,
    required this.startFraction,
  }) : super(key: key);

  @override
  State<_SingleCloud> createState() => _SingleCloudState();
}

class _SingleCloudState extends State<_SingleCloud>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    );

    // Initial phase of the animation, then loop forever
    _controller.value = widget.startFraction;
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final isNight = hour >= 20 || hour < 6;
    final opacity = isNight ? 0.08 : 0.55;

    final screenWidth = MediaQuery.of(context).size.width;
    final skyHeight = MediaQuery.of(context).size.height * 0.50;

    final cloudWidth = 60.0 * widget.scale;
    final actualCloudWidth = cloudWidth * 2.5;

    // Total travel = off-screen left → off-screen right
    final totalTravel = screenWidth + actualCloudWidth * 2;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Linear interpolation from -actualCloudWidth to maxWidth+actualCloudWidth
        final x = -actualCloudWidth + _controller.value * totalTravel;
        final y = widget.yFraction * skyHeight;

        return Positioned(
          left: x,
          top: y,
          child: CustomPaint(
            size: Size(actualCloudWidth, cloudWidth * 1.5),
            painter: _CloudBlobPainter(
              scale: widget.scale,
              opacity: opacity,
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// _CloudBlobPainter — draws a single fluffy cloud blob
// ---------------------------------------------------------------------------
class _CloudBlobPainter extends CustomPainter {
  final double scale;
  final double opacity;

  _CloudBlobPainter({required this.scale, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: opacity);

    final cx = size.width * 0.4;
    final cy = size.height * 0.5;
    final r = 20.0 * scale;

    // Cloud = cluster of overlapping circles
    canvas.drawCircle(Offset(cx, cy), r * 1.3, paint);
    canvas.drawCircle(Offset(cx - r * 1.2, cy + r * 0.3), r * 1.0, paint);
    canvas.drawCircle(Offset(cx + r * 1.2, cy + r * 0.25), r * 1.0, paint);
    canvas.drawCircle(Offset(cx - r * 0.5, cy - r * 0.55), r * 0.85, paint);
    canvas.drawCircle(Offset(cx + r * 0.6, cy - r * 0.5), r * 0.75, paint);
    canvas.drawCircle(Offset(cx, cy + r * 0.55), r * 1.1, paint);
  }

  @override
  bool shouldRepaint(_CloudBlobPainter old) =>
      old.scale != scale || old.opacity != opacity;
}
