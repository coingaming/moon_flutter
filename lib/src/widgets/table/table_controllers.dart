import 'package:flutter/cupertino.dart';

import 'package:moon_design/src/widgets/table/linked_scroll_controllers.dart';

class TableControllers {
  late ScrollController verticalScrollController;
  late ScrollController horizontalScrollController;

  final LinkedScrollControllerGroup _horizontalControllersGroup = LinkedScrollControllerGroup();

  final bool hasFixedHeader;
  final bool hasFixedFooter;
  final bool hasFixedRowsPlaceholder;
  final bool hasFixedPaginationPlaceholder;

  ScrollController? headerHorizontalScrollController;
  ScrollController? footerHorizontalScrollController;
  ScrollController? rowsPlaceholderScrollController;
  ScrollController? paginationPlaceHolderScrollController;

  TableControllers({
    required this.hasFixedHeader,
    required this.hasFixedFooter,
    required this.hasFixedPaginationPlaceholder,
    required this.hasFixedRowsPlaceholder,
  });

  void init() {
    verticalScrollController = ScrollController();
    horizontalScrollController = _horizontalControllersGroup.addAndGet();

    if (hasFixedHeader) headerHorizontalScrollController = _horizontalControllersGroup.addAndGet();
    if (hasFixedFooter) footerHorizontalScrollController = _horizontalControllersGroup.addAndGet();

    if (!hasFixedRowsPlaceholder) rowsPlaceholderScrollController = _horizontalControllersGroup.addAndGet();
    if (!hasFixedPaginationPlaceholder) paginationPlaceHolderScrollController = _horizontalControllersGroup.addAndGet();
  }

  void dispose() {
    verticalScrollController.dispose();
    horizontalScrollController.dispose();

    if (hasFixedHeader) headerHorizontalScrollController?.dispose();
    if (hasFixedFooter) footerHorizontalScrollController?.dispose();

    if (!hasFixedRowsPlaceholder) rowsPlaceholderScrollController?.dispose();
    if (!hasFixedPaginationPlaceholder) paginationPlaceHolderScrollController?.dispose();
  }
}
