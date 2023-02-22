import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

class ObfuscateTooltipItem extends StatefulWidget {
  /// This is just needed when the `ObfuscateTooltipItem` is placed outside the context
  /// of `ObfuscateTooltipLayoutState`, ie: In a modal route or an OverlayLayout
  final List<GlobalKey<MoonTooltipState>> tooltipKeys;

  final Widget child;

  const ObfuscateTooltipItem({
    super.key,
    required this.tooltipKeys,
    required this.child,
  });

  @override
  ObfuscateTooltipItemState createState() => ObfuscateTooltipItemState();
}

class ObfuscateTooltipItemState extends State<ObfuscateTooltipItem> with WidgetsBindingObserver {
  final GlobalKey _key = GlobalKey();

  late StreamSubscription<void> intervalSubcription;
  _PositionAndSize? _lastPositionSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    intervalSubcription = Stream.periodic(const Duration(seconds: 1)).listen((event) {
      final currentPositionSize = getPositionAndSize();
      if (_lastPositionSize != currentPositionSize) {
        _notifySizeChange(widget.tooltipKeys);
      }
      _lastPositionSize = currentPositionSize;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addToTooltips(widget.tooltipKeys);
    });
  }

  @override
  void didUpdateWidget(ObfuscateTooltipItem oldWidget) {
    if (oldWidget.tooltipKeys != widget.tooltipKeys) {
      _removeFromTooltips(oldWidget.tooltipKeys);
      _addToTooltips(widget.tooltipKeys);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    intervalSubcription.cancel();
    _removeFromTooltips(widget.tooltipKeys);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    _notifySizeChange(widget.tooltipKeys);
  }

  void _notifySizeChange(List<GlobalKey<MoonTooltipState>> keys) {
    if (keys.isNotEmpty) {
      for (final tooltipKey in keys) {
        tooltipKey.currentState?.doCheckForObfuscation();
      }
    }
  }

  _PositionAndSize? getPositionAndSize() {
    if (!mounted) return null;
    final RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return null;
    final position = renderBox.localToGlobal(Offset.zero);
    return _PositionAndSize(
      context: context,
      globalPosition: position,
      size: renderBox.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.child,
    );
  }

  void _addToTooltips(List<GlobalKey<MoonTooltipState>> keys) {
    if (keys.isNotEmpty) {
      for (final tooltipKey in keys) {
        tooltipKey.currentState?.addObfuscateItem(this);
      }
    }
  }

  void _removeFromTooltips(List<GlobalKey<MoonTooltipState>> keys) {
    if (keys.isNotEmpty) {
      for (final tooltipKey in keys) {
        tooltipKey.currentState?.removeObfuscatedItem(this);
      }
    }
  }
}

class _PositionAndSize {
  final BuildContext context;
  final Size size;
  final Offset globalPosition;
  _PositionAndSize({
    required this.context,
    required this.size,
    required this.globalPosition,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is _PositionAndSize && o.size == size && o.globalPosition == globalPosition;
  }

  @override
  int get hashCode => size.hashCode ^ globalPosition.hashCode;
}
