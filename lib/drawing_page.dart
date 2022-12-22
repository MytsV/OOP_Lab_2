import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oop_lab_2/shapes.dart';
import 'shape_editors.dart';
import 'shape_painter.dart';
import 'variant_values.dart';

class _Tool {
  final String name;
  final ShapeEditor editor;

  _Tool({required this.name, required this.editor});
}

class DrawingPage extends StatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  late _Tool _currentTool;
  late final List<_Tool> _tools;

  @override
  void initState() {
    super.initState();
    _tools = [
      _Tool(
          name: 'Крапка',
          editor: PointEditor(),),
      _Tool(
          name: 'Лінія',
          editor: LineEditor(),),
      _Tool(
          name: 'Прямокутник',
          editor: RectangleEditor()),
      _Tool(
          name: 'Еліпс',
          editor: EllipseEditor()),
    ];
    _currentTool = _tools.first;
  }

  _getButtonChild(_Tool tool) {
    if (_currentTool != tool) return Text(tool.name);
    //Якщо тип кнопки співпадає з типом вибраного Editor'а, відображаємо прапорець
    return Row(
      children: [
        Text(tool.name),
        const SizedBox(
          width: 5,
        ),
        Icon(Icons.check, color: Theme.of(context).primaryColor),
      ],
    );
  }

  Widget _getMenuChild() {
    return IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Об\'єкти'),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
    );
  }

  Widget _getMenuButton() => PopupMenuButton(
        child: _getMenuChild(),
        itemBuilder: (context) {
          return _tools
              .map((e) =>
                  PopupMenuItem<_Tool>(value: e, child: _getButtonChild(e)))
              .toList();
        },
        onSelected: (_Tool value) {
          setState(() {
            _currentTool = value;
          });
        },
      );

  //Отримуємо об'єкт, що задає стиль обведення поля малювання
  BoxDecoration _getDrawContainerDecoration() {
    return BoxDecoration(
        border: Border.all(
            style: BorderStyle.solid,
            color: Theme.of(context).primaryColor,
            width: BASE_STROKE_WIDTH + 1));
  }

  @override
  Widget build(BuildContext context) {
    ShapeEditor editor = _currentTool.editor;
    return Scaffold(
      appBar: AppBar(
        title: _getMenuButton(),
      ),
      body: Padding(
        //Робимо відступ між краями екрану й полем малювання
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: _getDrawContainerDecoration(),
          child: GestureDetector(
            onPanDown: editor.onPanDown,
            onPanUpdate: editor.onPanUpdate,
            onPanEnd: editor.onPanEnd,
            child: ClipRRect(
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                //Оновлюємо поле малювання з кожним оновленням списку фігур
                child: ValueListenableBuilder<List<Shape>>(
                  valueListenable: ShapeEditor.shapesListener,
                  builder: (context, shapes, _) => CustomPaint(
                    painter: ShapePainter(shapes),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
