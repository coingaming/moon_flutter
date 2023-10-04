import 'package:flutter/cupertino.dart';

import 'package:moon_design/src/utils/linked_scroll_controller.dart';

class TableControllers {
  late ScrollController verticalScrollController;
  late ScrollController horizontalScrollController;

  final LinkedScrollControllerGroup _horizontalControllersGroup = LinkedScrollControllerGroup();

  final bool fixedHeader;
  final bool fixedFooter;
  final bool fixedEmptyPlaceholder;

  ScrollController? headerHorizontalScrollController;
  ScrollController? footerHorizontalScrollController;
  ScrollController? emptyPlaceholderHorizontalScrollController;

  TableControllers({
    required this.fixedHeader,
    required this.fixedFooter,
    required this.fixedEmptyPlaceholder,
  });

  void init() {
    verticalScrollController = ScrollController();
    horizontalScrollController = _horizontalControllersGroup.addAndGet();

    if (fixedHeader) headerHorizontalScrollController = _horizontalControllersGroup.addAndGet();
    if (fixedFooter) footerHorizontalScrollController = _horizontalControllersGroup.addAndGet();
    if (!fixedEmptyPlaceholder) emptyPlaceholderHorizontalScrollController = _horizontalControllersGroup.addAndGet();
  }

  void dispose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();

    if (fixedHeader) headerHorizontalScrollController?.dispose();
    if (fixedFooter) footerHorizontalScrollController?.dispose();
    if (!fixedEmptyPlaceholder) emptyPlaceholderHorizontalScrollController?.dispose();
  }
}
