

import 'package:flutter/material.dart';

class RippleEffectPaint extends CustomPainter {
  final Color? color;//const Color(0xff653ff4);
  final double firstRippleRadius;
  final double firstRippleOpacity;
  final double firstRippleStrokeWidth;
  final double secondRippleRadius;
  final double secondRippleOpacity;
  final double secondRippleStrokeWidth;
  final double thirdRippleRadius;
  final double thirdRippleOpacity;
  final double thirdRippleStrokeWidth;
  final double centerCircleRadius;

  RippleEffectPaint(
      this.color,
      this.firstRippleRadius,
      this.firstRippleOpacity,
      this.firstRippleStrokeWidth,
      this.secondRippleRadius,
      this.secondRippleOpacity,
      this.secondRippleStrokeWidth,
      this.thirdRippleRadius,
      this.thirdRippleOpacity,
      this.thirdRippleStrokeWidth,
      this.centerCircleRadius);

  @override
  void paint(Canvas canvas, Size size) {
    Color myColor = color ?? Colors.blue;
    Offset offset = Offset(size.width*0.5, size.height*0.5);
    Paint firstPaint = Paint();
    firstPaint.color = myColor.withValues(alpha: firstRippleOpacity);
    firstPaint.style = PaintingStyle.stroke;
    firstPaint.strokeWidth = firstRippleStrokeWidth;
    canvas.drawCircle(offset, firstRippleRadius*size.width, firstPaint);

    Paint secondPaint = Paint();
    secondPaint.color = myColor.withValues(alpha: secondRippleOpacity, red: 0);
    secondPaint.style = PaintingStyle.stroke;
    secondPaint.strokeWidth = secondRippleStrokeWidth;

    canvas.drawCircle(offset, secondRippleRadius*size.width, secondPaint);

    Paint thirdPaint = Paint();
    thirdPaint.color = myColor.withValues(alpha: thirdRippleOpacity, green: 0);
    thirdPaint.style = PaintingStyle.stroke;
    thirdPaint.strokeWidth = thirdRippleStrokeWidth;

    canvas.drawCircle(offset, thirdRippleRadius*size.width, thirdPaint);

    Paint fourthPaint = Paint();
    fourthPaint.color = myColor;
    fourthPaint.style = PaintingStyle.fill;

    canvas.drawCircle(offset, centerCircleRadius*size.width, fourthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}