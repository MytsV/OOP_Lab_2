import 'dart:ui';
import 'package:flutter/material.dart';
import 'shapes.dart';

class ShapePainter extends CustomPainter {
  final List<Shape> shapes;
  ShapePainter(this.shapes);

  @override
  void paint(Canvas canvas, Size size) {
    for (Shape shape in shapes) {
      shape.show(canvas);
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) => true;
}
