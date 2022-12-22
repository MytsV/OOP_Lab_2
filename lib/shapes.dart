import 'dart:ui';
import 'package:flutter/material.dart';
import 'variant_values.dart';

enum ShapeType { regular, shadowed }

abstract class Shape {
  ShapeType type = ShapeType.regular;
  void show(Canvas canvas);
}

class PointShape extends Shape {
  final Offset position;

  PointShape(this.position);

  Paint get _paint {
    Paint paint = Paint();
    paint.color = BASE_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH + 1;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  @override
  void show(Canvas canvas) {
    canvas.drawPoints(PointMode.points, [position], _paint);
  }
}

class LineShape extends Shape {
  final Offset start;
  final Offset end;

  LineShape(this.start, this.end);

  Paint get _paint {
    Paint paint = Paint();
    paint.color = type == ShapeType.regular ? BASE_COLOR : SHADOW_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  @override
  void show(Canvas canvas) {
    canvas.drawLine(start, end, _paint);
  }
}

class RectangleShape extends Shape {
  final Offset leftUpper;
  final Offset rightLower;

  RectangleShape(this.leftUpper, this.rightLower);

  Paint get _strokePaint {
    Paint paint = Paint();
    paint.color = STROKE_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  Paint get _shadowPaint {
    Paint paint = Paint();
    paint.color = SHADOW_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  Paint get _paint {
    Paint paint = Paint();
    paint.color = BASE_COLOR;
    return paint;
  }

  @override
  void show(Canvas canvas) {
    Rect rect = Rect.fromPoints(leftUpper, rightLower);
    if (type == ShapeType.regular) {
      canvas.drawRect(rect, _paint);
      canvas.drawRect(rect, _strokePaint);
    } else {
      canvas.drawRect(rect, _shadowPaint);
    }
  }
}

class EllipseShape extends Shape {
  final Offset center;
  final Offset corner;

  EllipseShape(this.center, this.corner);

  Paint get _strokePaint {
    Paint paint = Paint();
    paint.color = STROKE_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  Paint get _paint {
    Paint paint = Paint();
    paint.color = ELLIPSE_FILL;
    return paint;
  }

  Paint get _shadowPaint {
    Paint paint = Paint();
    paint.color = SHADOW_COLOR;
    paint.strokeWidth = BASE_STROKE_WIDTH;
    paint.style = PaintingStyle.stroke;
    return paint;
  }

  @override
  void show(Canvas canvas) {
    double width = (center.dx - corner.dx).abs() * 2;
    double height = (center.dy - corner.dy).abs() * 2;
    Rect rect = Rect.fromCenter(center: center, width: width, height: height);
    if (type == ShapeType.regular) {
      canvas.drawOval(rect, _paint);
      canvas.drawOval(rect, _strokePaint);
    } else {
      canvas.drawOval(rect, _shadowPaint);
    }
  }
}
