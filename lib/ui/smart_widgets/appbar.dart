import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xFF651FFF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.0146875, size.height * 0.8975000,
        size.width * 0.0312500, size.height * 0.8900000);
    path_0.cubicTo(
        size.width * 0.2656250,
        size.height * 0.8925000,
        size.width * 0.7343750,
        size.height * 0.8975000,
        size.width * 0.9687500,
        size.height * 0.9000000);
    path_0.quadraticBezierTo(size.width * 0.9840625, size.height * 0.8950000,
        size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
