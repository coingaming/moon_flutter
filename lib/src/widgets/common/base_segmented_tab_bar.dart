import 'package:flutter/material.dart';

class BaseSegmentedTabBar extends StatefulWidget {
  final bool isExpanded;
  final double gap;
  final int selectedIndex;
  final TabController? tabController;
  final ValueChanged<int> valueChanged;
  final List<Widget> children;

  const BaseSegmentedTabBar({
    super.key,
    required this.isExpanded,
    required this.gap,
    required this.selectedIndex,
    this.tabController,
    required this.valueChanged,
    required this.children,
  });

  @override
  _BaseSegmentedTabBarState createState() => _BaseSegmentedTabBarState();
}

class _BaseSegmentedTabBarState extends State<BaseSegmentedTabBar> with SingleTickerProviderStateMixin {
  late List<GlobalKey> _tabKeys;
  late TabController? _controller;

  @override
  void initState() {
    super.initState();

    _tabKeys = widget.children.map((Widget tab) => GlobalKey()).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = widget.tabController ??
        DefaultTabController.maybeOf(context) ??
        TabController(length: widget.children.length, vsync: this, initialIndex: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(BaseSegmentedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.children.length > _tabKeys.length) {
      final int delta = widget.children.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.children.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.children.length, _tabKeys.length);
    }
  }

  @override
  void dispose() {
    _controller = null;
    // We don't own the _controller Animation, so it's not disposed here.
    super.dispose();
  }

  void _handleTap(int index) {
    assert(index >= 0 && index < widget.children.length);
    _controller!.animateTo(index);
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

          return widget.isExpanded
              ? index.isEven
                  ? Expanded(
                      child: Listener(
                        onPointerDown: (_) => _handleTap(derivedIndex),
                        child: widget.children[derivedIndex],
                      ),
                    )
                  : SizedBox(width: widget.gap)
              : index.isEven
                  ? Listener(
                      onPointerDown: (_) => _handleTap(derivedIndex),
                      child: widget.children[derivedIndex],
                    )
                  : SizedBox(width: widget.gap);
        },
      ),
    );
  }
}
