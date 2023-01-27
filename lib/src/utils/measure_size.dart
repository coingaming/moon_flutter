import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size size);

// Wrap this widget around your widget to get your widget size updates.
class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;
  final bool getInitialSize;

  const MeasureSize({
    super.key,
    required this.onChange,
    required Widget super.child,
    this.getInitialSize = false,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange: onChange, getInitialSize: getInitialSize);
  }
}

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetSizeChange onChange;
  final bool getInitialSize;

  MeasureSizeRenderObject({required this.onChange, this.getInitialSize = false});

  @override
  void performLayout() {
    super.performLayout();
    if (getInitialSize) {
      onChange(child!.size);
    } else {
      final newSize = child!.size;
      if (oldSize == newSize) return;

      oldSize = newSize;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChange(newSize);
      });
    }
  }
}
