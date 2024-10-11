import 'package:flutter/cupertino.dart';

import 'package:moon_design/src/utils/linked_scroll_controller.dart';

class TableControllers {
  late ScrollController verticalScrollController;
  late ScrollController horizontalScrollController;

  final LinkedScrollControllerGroup _horizontalControllersGroup =
      LinkedScrollControllerGroup();

  final bool isHeaderPinned;
  final bool isFooterPinned;
  final bool hasPinnedEmptyPlaceholder;

  ScrollController? headerHorizontalScrollController;
  ScrollController? footerHorizontalScrollController;
  ScrollController? rowsPlaceholderHorizontalScrollController;

  /// Creates Moon Design table controllers.
  TableControllers({
    required this.isHeaderPinned,
    required this.isFooterPinned,
    required this.hasPinnedEmptyPlaceholder,
  });

  void init() {
    verticalScrollController = ScrollController();
    horizontalScrollController = _horizontalControllersGroup.addAndGet();

    if (isHeaderPinned) {
      headerHorizontalScrollController =
          _horizontalControllersGroup.addAndGet();
    }
    if (isFooterPinned) {
      footerHorizontalScrollController =
          _horizontalControllersGroup.addAndGet();
    }
    if (!hasPinnedEmptyPlaceholder) {
      rowsPlaceholderHorizontalScrollController =
          _horizontalControllersGroup.addAndGet();
    }
  }

  void dispose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();

    if (isHeaderPinned) headerHorizontalScrollController?.dispose();
    if (isFooterPinned) footerHorizontalScrollController?.dispose();
    if (!hasPinnedEmptyPlaceholder) {
      rowsPlaceholderHorizontalScrollController?.dispose();
    }
  }
}
