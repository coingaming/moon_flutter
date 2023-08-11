import 'package:flutter/widgets.dart';

/// Widget that that will scroll to the top of the ScrollController when tapped on the status bar.
///
/// Extracted from Scaffold and used in modal bottom sheet
class ScrollToTopStatusBarHandler extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;

  const ScrollToTopStatusBarHandler({super.key, required this.scrollController, required this.child});

  @override
  ScrollToTopStatusBarState createState() => ScrollToTopStatusBarState();
}

class ScrollToTopStatusBarState extends State<ScrollToTopStatusBarHandler> {
  void _handleStatusBarTap(BuildContext context) {
    final ScrollController controller = widget.scrollController;

    if (controller.hasClients) {
      controller.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).padding.top,
          child: Builder(
            builder: (BuildContext context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _handleStatusBarTap(context),
              // iOS accessibility automatically adds scroll-to-top to the clock in the status bar
              excludeFromSemantics: true,
            ),
          ),
        ),
      ],
    );
  }
}
