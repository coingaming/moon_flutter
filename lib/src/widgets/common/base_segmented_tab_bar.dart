import 'package:flutter/material.dart';

class BaseSegmentedTabBar extends StatefulWidget {
  final bool isExpanded;
  final double gap;
  final TabController? tabController;
  final ValueChanged<int> valueChanged;
  final List<Widget> children;

  /// Creates a Moon Design base segmented tab bar.
  const BaseSegmentedTabBar({
    super.key,
    required this.isExpanded,
    required this.gap,
    this.tabController,
    required this.valueChanged,
    required this.children,
  });

  @override
  _BaseSegmentedTabBarState createState() => _BaseSegmentedTabBarState();
}

class _BaseSegmentedTabBarState extends State<BaseSegmentedTabBar>
    with TickerProviderStateMixin {
  late TabController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = widget.tabController ?? DefaultTabController.maybeOf(context);
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.children.length);

    _controller?.index = index;
    widget.valueChanged.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.children.length * 2 - 1,
        (int index) {
          final int derivedIndex = index ~/ 2;

          final Widget child = Listener(
            onPointerDown: (_) => _handleTap(derivedIndex),
            child: widget.children[derivedIndex],
          );

          return index.isEven
              ? widget.isExpanded
                  ? Expanded(child: child)
                  : child
              : SizedBox(width: widget.gap);
        },
      ),
    );
  }
}
