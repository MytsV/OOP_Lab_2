import 'package:flutter/material.dart';
import 'package:oop_lab_2/shapes.dart';
import 'editor.dart';

abstract class ShapeEditor implements Editor {
  static final shapesListener = ValueNotifier<List<Shape>>([]);
  Shape? _lastShape;
  
  void _onShapeFinished() {
    if (_lastShape != null) {
      shapesListener.value = List.from(shapesListener.value)
        ..remove(_lastShape);
      _lastShape!.type = ShapeType.regular;
      shapesListener.value = List.from(shapesListener.value)
        ..add(_lastShape!);
    }
    _lastShape = null;
  }

  void _onShapeUpdated(Shape shape) {
    shape.type = ShapeType.shadowed;
    if (_lastShape != null) {
      shapesListener.value = List.from(shapesListener.value)
        ..remove(_lastShape);
    }
    shapesListener.value = List.from(shapesListener.value)
      ..add(shape);
    _lastShape = shape;
  }
}

class PointEditor extends ShapeEditor {
  @override
  void onPanDown(DragDownDetails details) {
    var shape = PointShape(details.localPosition);
    _onShapeUpdated(shape);
    _onShapeFinished();
  }

  @override
  void onPanEnd(DragEndDetails details) {}

  @override
  void onPanUpdate(DragUpdateDetails details) {}
}

class LineEditor extends ShapeEditor {
  Offset? _start;

  @override
  void onPanDown(DragDownDetails details) {
    _start = details.localPosition;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    var shape = LineShape(_start!, details.localPosition);
    _onShapeUpdated(shape);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    _onShapeFinished();
  }
}

class RectangleEditor extends ShapeEditor {
  Offset? _start;

  @override
  void onPanDown(DragDownDetails details) {
    _start = details.localPosition;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    var shape = RectangleShape(_start!, details.localPosition);
    _onShapeUpdated(shape);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    _onShapeFinished();
  }
}

class EllipseEditor extends ShapeEditor {
  Offset? _start;

  @override
  void onPanDown(DragDownDetails details) {
    _start = details.localPosition;
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    var shape = EllipseShape(_start!, details.localPosition);
    _onShapeUpdated(shape);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    _onShapeFinished();
  }
}
