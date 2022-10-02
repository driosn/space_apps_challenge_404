import 'package:flutter/material.dart';

class ConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange.shade100.withOpacity(0.75)
      ..strokeWidth = 2;

    var path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width - size.width * 0.20, size.height);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width - size.width * 0.20, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
