import 'package:flutter/material.dart';
import 'package:shop/core/theme/app_colors.dart';

class NikeLogo extends StatelessWidget {
  const NikeLogo({super.key, this.height = 24});

  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(height * 2.8, height),
      painter: _SwooshPainter(),
    );
  }
}

class _SwooshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.05, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.15,
        size.width * 0.95,
        size.height * 0.35,
      )
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.75,
        size.width * 0.05,
        size.height * 0.55,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
