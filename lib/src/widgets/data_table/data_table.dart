// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

/// MoonTableRow to use in [MoonDataTable].
class MoonTableRow {
  final bool selected;
  final double? rowHeight;
  final Decoration? rowDecoration;
  final EdgeInsetsGeometry? rowPadding;
  final IndexedWidgetBuilder rowBuilder;
  final IndexedWidgetBuilder? rowStickyTitleBuilder;
  final ValueChanged<bool?>? onSelectChanged;
  final VoidCallback? onTap;

  const MoonTableRow({
    this.selected = false,
    this.rowHeight,
    this.rowDecoration,
    this.rowPadding,
    required this.rowBuilder,
    this.rowStickyTitleBuilder,
    this.onSelectChanged,
    this.onTap,
  });
}

typedef DataColumnSortCallback = void Function(int columnIndex, bool ascending);

/// MoonTableHeader to use in [MoonDataTable].
class MoonTableHeader {
  final double? rowHeight;
  final Decoration? rowDecoration;
  final List<Widget> headerItemsList;
  final EdgeInsetsGeometry? rowPadding;
  final VoidCallback? onTap;
  final DataColumnSortCallback? onSort;
  final IconData? sortingIcon;

  const MoonTableHeader({
    this.rowHeight,
    this.rowDecoration,
    required this.headerItemsList,
    this.onSort,
    this.rowPadding,
    this.onTap,
    this.sortingIcon,
  });
}

typedef OnScrollControllerReady = void Function(
  ScrollController verticalController,
  ScrollController horizontalController,
);

class MoonDataTable extends StatefulWidget {
  /// Enable right-to-left mode.
  final bool enableRTL;

  /// Controls whether the header of the table is fixed or not.
  final bool isFixedHeader;

  /// Controls whether the footer of the table is fixed or not.
  final bool isFixedFooter;

  final bool sortAscending;

  /// Background color of the fixed column.
  final Color? fixedColumnsBackgroundColor;

  /// Background color of the table body.
  final Color? tableBackgroundColor;

  /// Decoration for the table.
  final Decoration? tableDecoration;

  /// Fixed columns width of the table body.
  final double fixedColumnWidth;

  /// Gap between rows.
  final double? gap;

  /// Columns width of the table body.
  final double? tableWidth;

  /// The whole table widget height, including header, footer and table body.
  /// Defaults to null, uses up all available space. TableHeight must be greater than 0.
  final double? tableHeight;

  /// [ListView] itemExtent. Specifying an itemExtent is more efficient than letting the children
  /// determine their own extent because the scrolling machinery can make use of the foreknowledge
  /// of the children's extent to save work, for example when the scroll position changes drastically.
  ///When it is non-null, SliverFixedExtentList is used in [ListView].
  final double? itemExtent;

  final int? sortColumnIndex;

  /// Padding of the table body.
  final EdgeInsetsDirectional tablePadding;

  /// Count of rows to be built.
  final int rowsCount;

  /// Count of columns to be built.
  final int columnsCount;

  final IconData? sortArrowIcon;

  final Widget? Function(bool ascending, bool sorted)? sortArrowBuilder;

  /// Returning the horizontal and vertical controller for external usage.
  final OnScrollControllerReady? onScrollControllerReady;

  /// Vertical [Scrollbar] style. By default, the scrollbar is using the platform's system setting.
  final ScrollbarStyle? verticalScrollbarStyle;

  /// Horizontal [Scrollbar] style. By default, the scrollbar is using the platform's system setting.
  final ScrollbarStyle? horizontalScrollbarStyle;

  /// Vertical scroll physics of the data table.
  final ScrollPhysics? scrollPhysics;

  /// Horizontal Scroll physics of the data table.
  final ScrollPhysics? horizontalScrollPhysics;

  /// Builder for fixed rows items.
  final MoonTableRow? fixedRowsBuilder;

  /// Builder for [MoonTable] row items.
  final MoonTableRow? tableRow;

  /// Row divider widget. Applies to all data rows of the list view.
  final Widget? rowSeparatorWidget;

  /// List of header row children which fill the columns.
  final List<Widget>? headerWidgets;

  /// Widget to show when there are no row items.
  final Widget? placeHolder;

  /// Table header for [MoonTable] widget.
  final MoonTableHeader? tableHeader;

  /// List of footer row children which fill the columns.
  final List<Widget>? footerWidgets;

  const MoonDataTable({
    this.enableRTL = false,
    this.isFixedHeader = false,
    this.isFixedFooter = false,
    this.fixedColumnsBackgroundColor,
    this.tableBackgroundColor,
    this.tableDecoration,
    this.itemExtent,
    this.tableHeight,
    this.tablePadding = const EdgeInsetsDirectional.all(8),
    this.fixedColumnWidth = 0,
    this.gap,
    required this.rowsCount,
    required this.columnsCount,
    this.tableWidth,
    this.onScrollControllerReady,
    this.verticalScrollbarStyle,
    this.horizontalScrollbarStyle,
    this.scrollPhysics,
    this.horizontalScrollPhysics,
    this.headerWidgets,
    this.footerWidgets,
    this.fixedRowsBuilder,
    this.tableRow,
    this.placeHolder,
    this.tableHeader,
    this.rowSeparatorWidget,
    required this.sortAscending,
    this.sortColumnIndex,
    required this.sortArrowIcon,
    this.sortArrowBuilder,
  })  : assert(
          (isFixedHeader && tableHeader != null) || !isFixedHeader,
          'If fixed header is set to true, headerWidgets must not be null',
        ),
        assert(
          (isFixedFooter && footerWidgets != null) || !isFixedFooter,
          'if footer is fixed, footerWidgets must not be null',
        ),
        assert(tableHeight == null || tableHeight > 0.0, 'tableHeight can only be null or > 0.0'),
        assert(rowsCount >= 0, 'itemCount must >= 0'),
        assert(columnsCount > 0, 'itemCount must > 0');

  // const MoonDataTable.rtl({
  //   bool isFixedHeader = false,
  //   bool isFixedFooter = false,
  //   Color tableBackgroundColor = Colors.white,
  //   Color fixedColumnsBackgroundColor = Colors.white,
  //   double? itemExtent,
  //   double? tableHeight,
  //   double fixedColumnWidth = 0,
  //   int itemCount = 0,
  //   OnScrollControllerReady? onScrollControllerReady,
  //   ScrollbarStyle? verticalScrollbarStyle,
  //   ScrollbarStyle? horizontalScrollbarStyle,
  //   ScrollPhysics? scrollPhysics,
  //   ScrollPhysics? horizontalScrollPhysics,
  //   List<Widget>? headerWidgets,
  //   List<Widget>? footerWidgets,
  //   Widget Function(BuildContext, int)? rowsBuilder,
  //   Widget Function(BuildContext, int)? fixedRowsBuilder,
  //   Widget rowSeparatorWidget = const Divider(color: Colors.transparent, height: 0.0, thickness: 0.0),
  // }) : this(
  //         enableRTL: true,
  //         isFixedHeader: isFixedHeader,
  //         isFixedFooter: isFixedFooter,
  //         fixedColumnsBackgroundColor: fixedColumnsBackgroundColor,
  //         tableBackgroundColor: tableBackgroundColor,
  //         itemExtent: itemExtent,
  //         tableHeight: tableHeight,
  //         fixedColumnWidth: fixedColumnWidth,
  //         rowsCount: itemCount,
  //         onScrollControllerReady: onScrollControllerReady,
  //         verticalScrollbarStyle: verticalScrollbarStyle,
  //         horizontalScrollbarStyle: horizontalScrollbarStyle,
  //         scrollPhysics: scrollPhysics,
  //         horizontalScrollPhysics: horizontalScrollPhysics,
  //         headerWidgets: headerWidgets,
  //         footerWidgets: footerWidgets,
  //         rowsBuilder: rowsBuilder,
  //         fixedRowsBuilder: fixedRowsBuilder,
  //         rowSeparatorWidget: rowSeparatorWidget,
  //       );

  @override
  State<StatefulWidget> createState() {
    return _MoonDataTableState();
  }
}

class _MoonDataTableState extends State<MoonDataTable> {
  late TableControllers _tableControllers;

  @override
  void initState() {
    super.initState();
    _tableControllers = TableControllers(
      isFixedHeader: widget.isFixedHeader,
      isFixedFooter: widget.isFixedFooter,
    );

    _tableControllers.init();

    widget.onScrollControllerReady?.call(
      _tableControllers.verticalScrollController,
      _tableControllers.horizontalScrollController,
    );
  }

  @override
  void dispose() {
    _tableControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.enableRTL ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Container(
          padding: widget.tablePadding,
          decoration: widget.tableDecoration ??
              ShapeDecorationWithPremultipliedAlpha(
                color: widget.tableBackgroundColor ?? Colors.transparent,
                shape: MoonSquircleBorder(
                  borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                ),
              ),
          child: LayoutBuilder(
            builder: (context, boxConstraint) {
              late double maxHeight;
              late double maxWidth;

              if (widget.tableHeight != null) {
                maxHeight =
                    (boxConstraint.maxHeight > widget.tableHeight! ? widget.tableHeight : boxConstraint.maxHeight)!;
              } else {
                maxHeight = boxConstraint.maxHeight;
              }

              if (widget.tableWidth != null) {
                maxWidth = (boxConstraint.maxWidth > widget.tableWidth! ? widget.tableWidth : boxConstraint.maxWidth)!;
              } else {
                maxWidth = boxConstraint.maxWidth;
              }
              return _buildTableLayout(maxWidth, maxHeight);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTableLayout(double width, double height) {
    return CustomMultiChildLayout(
      delegate: TableBaseLayoutDelegate(height, width, widget.fixedColumnWidth, widget.enableRTL),
      children: [
        // if (widget.fixedRowsBuilder != null)
        //   LayoutId(
        //     id: BaseLayoutView.fixedRowListView,
        //     child: ColoredBox(
        //       color: widget.fixedColumnsBackgroundColor ?? Colors.transparent,
        //       child: _getFixedHeaderScrollColumn(
        //         height: height,
        //         listViewWidth: widget.fixedColumnWidth,
        //         header: widget.headerWidgets?.first,
        //         footer: widget.footerWidgets?.first,
        //         listView: _getListView(
        //           _tableControllers.fixedRowsListViewScrollController,
        //           widget.fixedRowsBuilder,
        //           widget.rowsCount,
        //         ),
        //       ),
        //     ),
        //   ),
        LayoutId(
          id: BaseLayoutView.rowScrollListView,
          child: _buildCoreTableLayout(
            height: height,
            listViewWidth: width - widget.fixedColumnWidth,
            // header: _buildHeader(),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children:
            //       widget.tableHeader?.headerItemsList.sublist(widget.fixedRowsBuilder != null ? 1 : 0).toList() ?? [],
            // ),
            footer: Row(
              mainAxisSize: MainAxisSize.min,
              children: widget.footerWidgets?.sublist(widget.fixedRowsBuilder != null ? 1 : 0).toList() ?? [],
            ),
            listView: _buildRows(),
          ),
        ),
      ],
    );
  }

  // Widget _getFixedHeaderScrollColumn({
  //   required double height,
  //   required double listViewWidth,
  //   Widget? header,
  //   Widget? footer,
  //   required Widget listView,
  // }) {
  //   return CustomMultiChildLayout(
  //     delegate: ListViewLayoutDelegate(
  //       height,
  //       listViewWidth,
  //     ),
  //     children: [
  //       if (widget.isFixedHeader)
  //         LayoutId(
  //           id: ListViewLayout.header,
  //           child: header!,
  //         ),
  //       // if (widget.isFixedHeader)
  //       //   LayoutId(
  //       //     id: ListViewLayout.divider,
  //       //     child: widget.rowSeparatorWidget,
  //       //   ),
  //       // if (widget.isFixedFooter)
  //       //   LayoutId(
  //       //     id: ListViewLayout.footerDivider,
  //       //     child: widget.rowSeparatorWidget,
  //       //   ),
  //       LayoutId(
  //         id: ListViewLayout.listView,
  //         child: listView,
  //       ),
  //       if (widget.isFixedFooter)
  //         LayoutId(
  //           id: ListViewLayout.footer,
  //           child: footer!,
  //         ),
  //     ],
  //   );
  // }

  Widget _buildCoreTableLayout({
    required double height,
    required double listViewWidth,
    required Widget listView,
    Widget? footer,
  }) {
    return CustomMultiChildLayout(
      delegate: ListViewLayoutDelegate(height, listViewWidth),
      children: [
        if (widget.isFixedHeader)
          LayoutId(
            id: ListViewLayout.header,
            child: SingleChildScrollView(
              physics: widget.horizontalScrollPhysics,
              controller: _tableControllers.bidirectionalSideHeaderHorizontalScrollController,
              scrollDirection: Axis.horizontal,
              // child: header,
              child: SizedBox(
                width: widget.tableWidth,
                child: _buildHeader(),
              ),
            ),
          ),

        // if (widget.isFixedHeader)
        //   LayoutId(
        //     id: ListViewLayout.divider,
        //     child: widget.rowSeparatorWidget!,
        //   ),
        // if (widget.isFixedFooter)
        //   LayoutId(
        //     id: ListViewLayout.footerDivider,
        //     child: widget.rowSeparatorWidget!,
        //   ),

        if (widget.rowsCount <= 0)
          LayoutId(id: ListViewLayout.placeHolder, child: widget.placeHolder ?? const SizedBox())
        else
          LayoutId(
            id: ListViewLayout.listView,
            child: CustomScrollBar(
              controller: _tableControllers.verticalScrollController,
              scrollbarStyle: widget.verticalScrollbarStyle,
              notificationPredicate: (ScrollNotification notification) => notification.depth == 1,
              child: CustomScrollBar(
                controller: _tableControllers.horizontalScrollController,
                scrollbarStyle: widget.horizontalScrollbarStyle,
                notificationPredicate: (notification) {
                  // For some reason, on  _web only_, the scrollbar catches notifications from a vertical
                  // scrollable with depth: 0. This causes issues with the horizontal scrollbar disappearing
                  // as soon as vertical scrolling starts, and not obeying the fade logic or `isShownAlways` styling.
                  // As a workaround, we check the axis of the source scrollable.
                  if (notification.depth == 0 && notification.metrics.axis == Axis.horizontal) return true;

                  return false;
                },
                child: SingleChildScrollView(
                  physics: widget.horizontalScrollPhysics,
                  controller: _tableControllers.horizontalScrollController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: widget.tableWidth,
                    child: listView,
                  ),
                ),
              ),
            ),
          ),
        if (widget.isFixedFooter)
          LayoutId(
            id: ListViewLayout.footer,
            child: SingleChildScrollView(
              physics: widget.horizontalScrollPhysics,
              controller: _tableControllers.bidirectionalSideFooterHorizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: footer,
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    if (widget.tableHeader != null && widget.tableHeader!.headerItemsList.isNotEmpty) {
      return Container(
        height: widget.tableHeader?.rowHeight,
        decoration: widget.tableHeader?.rowDecoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.tableHeader!.headerItemsList.length,
            (int index) {
              return GestureDetector(
                onTap: () => widget.tableHeader?.onSort?.call(index, !widget.sortAscending),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.tableHeader!.headerItemsList[index],
                    if (widget.tableHeader!.onSort != null)
                      _SortArrow(
                        icon: widget.tableHeader!.sortingIcon ?? MoonIcons.chevron_up_16,
                        visible: index == widget.sortColumnIndex,
                        up: index == widget.sortColumnIndex ? widget.sortAscending : null,
                        duration: const Duration(milliseconds: 200),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );

      //   return MouseRegion(
      //     onHover: (event) {},
      //     cursor: SystemMouseCursors.basic,
      //     child: GestureDetector(
      //       onTap: () => widget.tableHeader?.onTap?.call(),
      //       child: Container(
      //         height: widget.tableHeader?.rowHeight,
      //         padding: widget.tableHeader?.rowPadding,
      //         margin: EdgeInsets.only(bottom: index == widget.columnsCount - 1 ? 0 : widget.gap ?? 16),
      //         decoration: widget.tableHeader?.rowDecoration,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             widget.tableHeader!.headerItemsList[index],
      //             if (widget.rowSeparatorWidget != null && index != widget.columnsCount - 1) widget.rowSeparatorWidget!,
      //           ],
      //         ),
      //       ),
      //     ),
      //   );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildRows() {
    if (widget.tableRow != null) {
      return ListView.builder(
        physics: widget.scrollPhysics,
        controller: _tableControllers.verticalScrollController,
        itemCount: widget.rowsCount,
        itemExtent: widget.itemExtent,
        itemBuilder: (BuildContext context, int index) {
          final bool hasScrollableHeader = !widget.isFixedHeader;
          final bool isLastRow = index == widget.rowsCount - 1;
          final bool isFirstRow = index == 0;
          final double gap = (widget.gap ?? 16) / 2;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasScrollableHeader && index == 0) _buildHeader(),
              MouseRegion(
                onHover: (event) {},
                cursor: SystemMouseCursors.basic,
                child: GestureDetector(
                  onTap: () => {
                    widget.tableRow!.onSelectChanged?.call(!widget.tableRow!.selected),
                    widget.tableRow?.onTap?.call()},
                  child: Container(
                    height: widget.tableRow!.rowHeight,
                    padding: widget.tableRow!.rowPadding,
                    margin: EdgeInsets.only(bottom: isLastRow ? 0 : gap, top: isFirstRow ? 0 : gap),
                    decoration: widget.tableRow!.rowDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.tableRow!.rowStickyTitleBuilder != null)
                          AnimatedBuilder(
                            animation: _tableControllers.horizontalScrollController,
                            builder: (BuildContext context, Widget? child) {
                              double widgetOffset = 0;
                              bool offsetIsIncreasing = false;
                              double scrollOffset = _tableControllers.horizontalScrollController.offset;
                              offsetIsIncreasing = (scrollOffset - widgetOffset) > 0;

                              if (scrollOffset < 0) scrollOffset = 0;
                              if (widgetOffset != scrollOffset) widgetOffset = scrollOffset;

                              final double effectiveOffsetPadding =
                                  widget.tableRow?.rowPadding?.resolve(Directionality.of(context)).left ?? 0;

                              return Padding(
                                padding: EdgeInsets.only(left: widgetOffset + effectiveOffsetPadding, bottom: 4),
                                child: AnimatedDefaultTextStyle(
                                  style: MoonTypography.typography.body.textDefault.copyWith(
                                    color: offsetIsIncreasing
                                        ? context.moonColors!.textPrimary.withOpacity(0.4)
                                        : context.moonColors!.textPrimary,
                                  ),
                                  duration: const Duration(milliseconds: 400),
                                  child: child!,
                                ),
                              );
                            },
                            child: widget.tableRow!.rowStickyTitleBuilder!(context, index),
                          ),
                        widget.tableRow!.rowBuilder(context, index),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.rowSeparatorWidget != null && !isLastRow) widget.rowSeparatorWidget!,
            ],
          );
        },
      );
    }
    return const SizedBox();
  }
}

class TableBaseLayoutDelegate extends MultiChildLayoutDelegate {
  final bool isRTL;
  final double widgetHeight;
  final double widgetWidth;
  final double headerWidth;

  TableBaseLayoutDelegate(
    this.widgetHeight,
    this.widgetWidth,
    this.headerWidth, [
    this.isRTL = false,
  ]);

  @override
  void performLayout(Size size) {
    isRTL ? _performRTLLayout(size) : _performLTRLayout(size);
  }

  void _performLTRLayout(Size size) {
    Size fixedListViewSize = Size.zero;

    if (hasChild(BaseLayoutView.fixedRowListView)) {
      fixedListViewSize = layoutChild(
        BaseLayoutView.fixedRowListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: headerWidth,
        ),
      );

      positionChild(BaseLayoutView.fixedRowListView, Offset.zero);
    }

    if (hasChild(BaseLayoutView.rowScrollListView)) {
      layoutChild(
        BaseLayoutView.rowScrollListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: widgetWidth - fixedListViewSize.width,
        ),
      );

      positionChild(BaseLayoutView.rowScrollListView, Offset(fixedListViewSize.width, 0));
    }
  }

  void _performRTLLayout(Size size) {
    Size fixedSideListViewSize = Size.zero;

    if (hasChild(BaseLayoutView.fixedRowListView)) {
      fixedSideListViewSize = layoutChild(
        BaseLayoutView.fixedRowListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: headerWidth,
        ),
      );

      positionChild(BaseLayoutView.fixedRowListView, Offset(widgetWidth - fixedSideListViewSize.width, 0));
    }

    if (hasChild(BaseLayoutView.rowScrollListView)) {
      layoutChild(
        BaseLayoutView.rowScrollListView,
        BoxConstraints(
          maxHeight: widgetHeight,
          maxWidth: widgetWidth - fixedSideListViewSize.width,
        ),
      );

      positionChild(BaseLayoutView.rowScrollListView, Offset.zero);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => this != oldDelegate;
}

enum BaseLayoutView {
  fixedRowListView,
  rowScrollListView,
  middleShadow,
  divider,
}

class ListViewLayoutDelegate extends MultiChildLayoutDelegate {
  final double widgetHeight;
  final double widgetWidth;

  ListViewLayoutDelegate(this.widgetHeight, this.widgetWidth);

  @override
  void performLayout(Size size) {
    Size headerSize = Size.zero;
    Size footerSize = Size.zero;
    Size dividerSize = Size.zero;
    if (hasChild(ListViewLayout.header)) {
      headerSize = layoutChild(
        ListViewLayout.header,
        BoxConstraints(maxWidth: widgetWidth, maxHeight: widgetHeight),
      );

      positionChild(ListViewLayout.header, Offset.zero);
    }

    if (hasChild(ListViewLayout.divider)) {
      dividerSize = layoutChild(
        ListViewLayout.divider,
        BoxConstraints(maxWidth: widgetWidth),
      );

      positionChild(ListViewLayout.divider, Offset(0, headerSize.height));
    }

    if (hasChild(ListViewLayout.footer)) {
      footerSize = layoutChild(
        ListViewLayout.footer,
        BoxConstraints(maxWidth: widgetWidth, maxHeight: widgetHeight),
      );

      positionChild(ListViewLayout.footer, Offset(0, widgetHeight - footerSize.height));
    }

    if (hasChild(ListViewLayout.footerDivider)) {
      dividerSize = layoutChild(
        ListViewLayout.footerDivider,
        BoxConstraints(maxWidth: widgetWidth),
      );

      positionChild(ListViewLayout.footerDivider, Offset(0, widgetHeight - footerSize.height));
    }

    if (hasChild(ListViewLayout.listView)) {
      layoutChild(
        ListViewLayout.listView,
        BoxConstraints(maxHeight: widgetHeight - headerSize.height - footerSize.height, maxWidth: widgetWidth),
      );

      positionChild(ListViewLayout.listView, Offset(0, headerSize.height + dividerSize.height));
    }

    if (hasChild(ListViewLayout.placeHolder)) {
      layoutChild(
        ListViewLayout.placeHolder,
        BoxConstraints(maxHeight: widgetHeight, maxWidth: widgetWidth),
      );

      positionChild(ListViewLayout.placeHolder, Offset(0, headerSize.height));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return this != oldDelegate;
  }
}

enum ListViewLayout {
  header,
  placeHolder,
  listView,
  divider,
  footer,
  footerDivider,
}

class CustomScrollBar extends StatelessWidget {
  final ScrollController controller;
  final ScrollbarStyle? scrollbarStyle;
  final Widget child;
  final ScrollNotificationPredicate notificationPredicate;

  const CustomScrollBar({
    super.key,
    required this.controller,
    this.scrollbarStyle,
    required this.child,
    this.notificationPredicate = defaultScrollNotificationPredicate,
  });

  @override
  Widget build(BuildContext context) {
    if (scrollbarStyle?.thumbColor != null) {
      return RawScrollbar(
        controller: controller,
        thumbVisibility: scrollbarStyle?.isAlwaysShown ?? false,
        thickness: scrollbarStyle?.thickness,
        radius: scrollbarStyle?.radius,
        thumbColor: scrollbarStyle?.thumbColor,
        notificationPredicate: notificationPredicate,
        child: child,
      );
    }

    return Scrollbar(
      controller: controller,
      thumbVisibility: scrollbarStyle?.isAlwaysShown ?? false,
      thickness: scrollbarStyle?.thickness,
      radius: scrollbarStyle?.radius,
      notificationPredicate: notificationPredicate,
      child: child,
    );
  }
}

class ScrollbarStyle {
  ///Set whether always display thumb
  final bool isAlwaysShown;

  ///Set the thickness of thumb. If thickness is null, the default value is platform dependent.
  final double? thickness;

  ///Set raius of the thumb. If radius is null, the default value is platform dependent.
  final Radius? radius;

  ///Set customized thumb color. If thumbColor is null, the default value is platform dependent.
  final Color? thumbColor;

  const ScrollbarStyle({
    this.isAlwaysShown = false,
    this.thickness,
    this.radius,
    this.thumbColor,
  });
}

class TableControllers {
  late LinkedScrollControllerGroup _controllersGroup;
  late ScrollController fixedRowsListViewScrollController;
  late ScrollController verticalScrollController;

  late LinkedScrollControllerGroup _horizontalControllersGroup;
  late ScrollController horizontalScrollController;
  ScrollController? bidirectionalSideHeaderHorizontalScrollController;
  ScrollController? bidirectionalSideFooterHorizontalScrollController;

  final bool isFixedHeader;
  final bool isFixedFooter;

  TableControllers({
    required this.isFixedHeader,
    required this.isFixedFooter,
  });

  void init() {
    _initVerticalControllers();
    _initBidirectionalSideHorizontalScrollController();
    _initBidirectionalSideHorizontalHeaderScrollController();
    _initBidirectionalSideHorizontalFooterScrollController();
  }

  void dispose() {
    fixedRowsListViewScrollController.dispose();
    verticalScrollController.dispose();
    horizontalScrollController.dispose();

    if (isFixedHeader) {
      bidirectionalSideHeaderHorizontalScrollController?.dispose();
    }
    if (isFixedFooter) {
      bidirectionalSideFooterHorizontalScrollController?.dispose();
    }
  }

  void _initVerticalControllers() {
    _controllersGroup = LinkedScrollControllerGroup();
    fixedRowsListViewScrollController = _controllersGroup.addAndGet();
    verticalScrollController = _controllersGroup.addAndGet();
  }

  void _initBidirectionalSideHorizontalScrollController() {
    _horizontalControllersGroup = LinkedScrollControllerGroup();
    horizontalScrollController = _horizontalControllersGroup.addAndGet();
  }

  void _initBidirectionalSideHorizontalHeaderScrollController() {
    if (isFixedHeader) {
      bidirectionalSideHeaderHorizontalScrollController = _horizontalControllersGroup.addAndGet();
    }
  }

  void _initBidirectionalSideHorizontalFooterScrollController() {
    if (isFixedFooter) {
      bidirectionalSideFooterHorizontalScrollController = _horizontalControllersGroup.addAndGet();
    }
  }
}

class _SortArrow extends StatefulWidget {
  final bool visible;
  final bool? up;
  final Duration duration;
  final IconData icon;

  const _SortArrow({required this.visible, required this.up, required this.duration, required this.icon});

  @override
  _SortArrowState createState() => _SortArrowState();
}

class _SortArrowState extends State<_SortArrow> with TickerProviderStateMixin {
  static const double _arrowIconBaselineOffset = -1.5;
  static const double _arrowIconSize = 16.0;

  static final Animatable<double> _turnTween =
      Tween<double>(begin: 0.0, end: pi).chain(CurveTween(curve: Curves.easeIn));

  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  late AnimationController _orientationController;
  late Animation<double> _orientationAnimation;

  bool? _up;
  double _orientationOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _up = widget.up;

    _opacityAnimation = CurvedAnimation(
      parent: _opacityController = AnimationController(duration: widget.duration, vsync: this),
      curve: Curves.fastOutSlowIn,
    )..addListener(_rebuild);
    _opacityController.value = widget.visible ? 1.0 : 0.0;

    _orientationController = AnimationController(duration: widget.duration, vsync: this);
    _orientationAnimation = _orientationController.drive(_turnTween)
      ..addListener(_rebuild)
      ..addStatusListener(_resetOrientationAnimation);
    if (widget.visible) _orientationOffset = widget.up! ? 0.0 : pi;
  }

  void _rebuild() {
    setState(() {
      // The animations changed, so we need to rebuild.
    });
  }

  void _resetOrientationAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      assert(_orientationAnimation.value == pi);

      _orientationOffset += pi;
      _orientationController.value = 0.0; // TODO(ianh): This triggers a pointless rebuild.
    }
  }

  @override
  void didUpdateWidget(_SortArrow oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool? newUp = widget.up ?? _up;
    bool skipArrow = false;

    if (oldWidget.visible != widget.visible) {
      if (widget.visible && (_opacityController.status == AnimationStatus.dismissed)) {
        _orientationController.stop();
        _orientationController.value = 0.0;
        _orientationOffset = newUp! ? 0.0 : pi;
        skipArrow = true;
      }
      widget.visible ? _opacityController.forward() : _opacityController.reverse();
    }
    if (_up != newUp && !skipArrow) {
      _orientationController.status == AnimationStatus.dismissed
          ? _orientationController.forward()
          : _orientationController.reverse();
    }
    _up = newUp;
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _orientationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Transform(
        transform: Matrix4.rotationZ(_orientationOffset + _orientationAnimation.value)
          ..setTranslationRaw(0.0, _arrowIconBaselineOffset, 0.0),
        alignment: Alignment.center,
        child: Icon(
          widget.icon,
          size: _arrowIconSize,
        ),
      ),
    );
  }
}

// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // Copyright 2021 Maxim Saplin - changes and modifications to original Flutter implementation of DataTable
//
// import 'dart:math' as math;
//
// import 'package:flutter/material.dart';
// import 'package:moon_design/moon_design.dart';
//
// import 'package:moon_design/src/utils/extensions.dart';
// import 'package:moon_design/src/utils/shape_decoration_premul.dart';
// import 'package:moon_design/src/utils/squircle/squircle_border.dart';
// import 'package:moon_design/src/widgets/data_table/linked_scroll_controllers.dart';
//
// /// Extension of [DataColumn], adds the capability to set column fixed width.
// @immutable
// class MoonDataColumn extends DataColumn {
//   /// Defines width of the column.
//   /// If the total width of columns exceeds table width, columns will be clipped.
//   final double? fixedWidth;
//
//   const MoonDataColumn({
//     required super.label,
//     super.tooltip,
//     super.numeric = false,
//     super.onSort,
//     this.fixedWidth,
//   });
// }

// /// Extension of [DataCell]. The data for one row cell of a [MoonDataTable].
// ///
// /// List of [MoonDataCell] objects must be provided for each [MoonDataRow] in the [MoonDataTable].
// @immutable
// class MoonDataCell extends DataCell {
//   /// Creates an object to hold the data for a row cell in a [MoonDataTable].
//   ///
//   /// The first argument is the widget to show for the cell,
//   /// typically a [Text] or [DropdownButton] widget.
//   /// This becomes the [child] property and must not be null.
//   ///
//   /// If the cell has no data, then a [Text] widget with placeholder text should be
//   /// provided and the [placeholder] argument must be set to true.
//   const MoonDataCell(
//     super.child, {
//     super.placeholder,
//     super.showEditIcon,
//     super.onTap,
//     super.onDoubleTap,
//     super.onTapDown,
//     super.onTapCancel,
//     super.onLongPress,
//   });
// }
//
// /// Extension of [DataRow] class, adds row level tap events.
// /// OnSecondaryTap and onSecondaryTapDown provide action on desktop settings
// /// when a reaction to the right click is required.
// @immutable
// class MoonDataRow extends DataRow {
//   /// Height of the row.
//   final double? rowHeight;
//
//   /// Row's tap handler. Will not be called if tapped cell inside the row has any tap event handlers.
//   final GestureTapCallback? onTap;
//
//   /// Row's double tap handler. Will not be called if tapped cell inside the row has any tap event handlers.
//   final GestureTapCallback? onDoubleTap;
//
//   /// Row's right click handler. Will not be called if tapped cell inside the row has any tap event handlers.
//   final GestureTapCallback? onSecondaryTap;
//
//   /// Row's right mouse down handler. Will not be called if tapped cell inside the row has any tap event handlers.
//   final GestureTapDownCallback? onSecondaryTapDown;
//
//   /// Creates the configuration for a row of a [MoonDataTable].
//   ///
//   /// The [cells] argument must not be null.
//   const MoonDataRow({
//     super.key,
//     required super.cells,
//     super.selected = false,
//     super.color,
//     super.onSelectChanged,
//     super.onLongPress,
//     this.rowHeight,
//     this.onTap,
//     this.onDoubleTap,
//     this.onSecondaryTap,
//     this.onSecondaryTapDown,
//   });
//
//   MoonDataRow.byIndex({
//     required super.cells,
//     super.selected = false,
//     super.index,
//     super.color,
//     super.onSelectChanged,
//     super.onLongPress,
//     this.rowHeight,
//     this.onTap,
//     this.onDoubleTap,
//     this.onSecondaryTap,
//     this.onSecondaryTapDown,
//   }) : super.byIndex();
// }
//
// /// Extension of [DataTable] widget.
// /// [MoonDataTable] has the header row fixed by default and table's body is horizontally and vertically scrollable.
// /// Content is stretching to max width/height of it's container.
// class MoonDataTable extends DataTable {
//   /// The default height of the heading row.
//   static const double _headingRowHeight = 56.0;
//
//   /// The default horizontal margin between the edges of the table and the content
//   /// in the first and last cells of each row.
//   static const double _horizontalMargin = 24.0;
//
//   /// The default horizontal margin between the checkbox of each data column.
//   static const double _columnSpacing = 56.0;
//
//   /// The default padding between the heading content and sort arrow.
//   static const double _sortArrowPadding = 2.0;
//
//   /// The default divider thickness.
//   static const double _dividerThickness = 1.0;
//
//   /// Alignment of the checkbox if displayed. Defaults to the [Alignment.center].
//   final Alignment checkboxAlignment;
//
//   /// Determines whether the horizontal scroll bar is visible.
//   final bool? isHorizontalScrollBarVisible;
//
//   /// Determines whether the vertical scroll bar is visible.
//   final bool? isVerticalScrollBarVisible;
//
//   /// Controls whether to show default cell divider or not.
//   final bool showCellDivider;
//
//   /// Controls whether to show default cell divider or not.
//   final bool showHeaderDivider;
//
//   /// Overrides the theme of the checkbox displayed in the leftmost corner of the heading.
//   final CheckboxThemeData? headingCheckboxTheme;
//
//   /// Overrides the theme of the checkbox displayed in the checkbox column of each [MoonDataRow].
//   final CheckboxThemeData? dataRowCheckboxTheme;
//
//   /// Background color of the sticky columns fixed via [fixedLeftColumns].
//   /// This color is static and doesn't respond to state change.
//   /// To change background color of fixed data rows, use [MoonDataTable.headingRowColor].
//   final Color? fixedColumnsColor;
//
//   /// Background color of the top left corner which is fixed when both [fixedTopRows]
//   /// and [fixedLeftColumns] are greater than 0.
//   /// This color is static and doesn't respond to state change.
//   /// To change background color of fixed data rows use [MoonDataTable.headingRowColor].
//   final Color? fixedCornerColor;
//
//   /// Background color of the even rows creating a zebra-style effect.
//   /// For the odd rows, the [dataRowColor] is used.
//   final Color? evenRowColor;
//
//   /// Custom decoration for [MoonDataCell].
//   final Decoration? cellDecoration;
//
//   /// Custom decoration for [MoonDataRow].
//   final Decoration? rowDecoration;
//
//   /// If set, the table will have empty space added after the the last [MoonDataRow].
//   /// This is useful when the table is placed in a [Scaffold] with a [BottomNavigationBar].
//   final double? bottomMargin;
//
//   /// The height of each row (excluding heading row).
//   ///
//   //TODO should be MoonDesign specific height.
//   /// If null, [DataTableThemeData.dataRowMinHeight] is used. This value defaults
//   /// to [kMinInteractiveDimension] to adhere to the Material Design specifications.
//   @override
//   final double? dataRowHeight;
//
//   /// If set, the [MoonDataTable] will have a minimum width.
//   /// If table content exceeds the minimum width, the table will become horizontally scrollable.
//   final double? minTableWidth;
//
//   /// Vertical spacing between the rows. Defaults to 0.
//   final double? rowSpacing;
//
//   /// When changing sort direction an arrow icon in the header is rotated clockwise.
//   /// The value defines the duration of the rotation animation.
//   // TODO should be optional. Assign moon default.
//   final Duration sortArrowAnimationDuration;
//
//   /// The number of sticky rows fixed at the top of the table.
//   /// By default the value is 1, including fixed heading.
//   /// Set to 0 in order to unstick the header, set to >1 in order to fix data rows.
//   final int fixedTopRows;
//
//   /// Number of sticky columns fixed at the left side of the table.
//   final int fixedLeftColumns;
//
//   /// Icon to be displayed when sorting is applied to a column.
//   // TODO should be optional. Assign moon default.
//   final IconData sortArrowIcon;
//
//   /// Set vertical and horizontal borders between cells, as well as outside borders around table.
//   @override
//   // ignore: overridden_fields
//   final TableBorder? border;
//
//   /// Exposes scroll controller of the SingleChildScrollView which makes data rows vertically scrollable.
//   final ScrollController? scrollController;
//
//   /// Exposes scroll controller of the SingleChildScrollView which makes data rows horizontally scrollable.
//   final ScrollController? horizontalScrollController;
//
//   /// A builder for the sort arrow widget.
//   /// Can be used in combination with [sortArrowAlwaysVisible] for a custom sort arrow behavior.
//   /// If builder is used, [sortArrowIcon] and [sortArrowAnimationDuration] will be ignored.
//   final Widget? Function(bool ascending, bool sorted)? sortArrowBuilder;
//
//   /// Placeholder widget which is displayed whenever the [rows] list is empty.
//   /// The widget will be displayed below heading row.
//   final Widget? placeHolder;
//
//   MoonDataTable({
//     super.key,
//     required super.columns,
//     required List<MoonDataRow> rows,
//     // required super.rows,
//     super.sortAscending = true,
//     super.showCheckboxColumn = true,
//     super.showBottomBorder = false,
//
//     /// MaterialColorisse ei saa anda moon colorit! Tuleb üle kirjutada.
//     super.dataRowColor,
//     super.headingRowColor,
//     super.clipBehavior,
//     super.decoration,
//     super.headingRowHeight,
//     super.horizontalMargin,
//     super.checkboxHorizontalMargin,
//     super.columnSpacing,
//     super.dividerThickness,
//     super.sortColumnIndex,
//     super.dataTextStyle,
//     super.headingTextStyle,
//     super.onSelectAll,
//     this.checkboxAlignment = Alignment.center,
//     this.isHorizontalScrollBarVisible,
//     this.isVerticalScrollBarVisible,
//     this.showCellDivider = false,
//     this.showHeaderDivider = false,
//     this.headingCheckboxTheme,
//     this.dataRowCheckboxTheme,
//     this.fixedColumnsColor,
//     this.fixedCornerColor,
//     this.evenRowColor,
//     this.cellDecoration,
//     this.rowDecoration,
//     this.bottomMargin,
//     this.dataRowHeight,
//     this.minTableWidth,
//     this.rowSpacing,
//     this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
//     this.fixedTopRows = 1,
//     this.fixedLeftColumns = 0,
//     this.sortArrowIcon = Icons.arrow_upward,
//     this.border,
//     this.scrollController,
//     this.horizontalScrollController,
//     this.sortArrowBuilder,
//     this.placeHolder,
//   })  : assert(fixedLeftColumns >= 0, 'fixedLeftColumns must be greater or equal to 0'),
//         assert(fixedTopRows >= 0, 'fixedTopRows must be greater or equal to 0'),
//         super(rows: _addSpaceBetweenRows(rows, rowSpacing));
//
//   static final LocalKey _headingRowKey = UniqueKey();
//   static const LocalKey _spacerRowKey = ValueKey('MoonRowSpacerValueKey');
//
//   static List<MoonDataRow> _addSpaceBetweenRows(List<MoonDataRow> originalRows, double? rowSpacing) {
//     final rowsWithSpacer = <MoonDataRow>[];
//
//     for (int index = 0; index < originalRows.length; index++) {
//       final row = originalRows[index];
//
//       rowsWithSpacer.add(row);
//
//       if (index != originalRows.length - 1) {
//         rowsWithSpacer.add(_createEmptyRows(row.cells.length, rowSpacing));
//       }
//     }
//
//     return rowsWithSpacer;
//   }
//
//   static MoonDataRow _createEmptyRows(int cellsCount, double? rowSpacing) {
//     return MoonDataRow(
//       key: _spacerRowKey,
//       rowHeight: rowSpacing ?? 0,
//       cells: List.generate(
//         cellsCount,
//         (index) => const MoonDataCell(SizedBox()),
//       ).toList(),
//     );
//   }
//
//   void _handleSelectAll(bool? checked, bool someChecked) {
//     final bool effectiveChecked = someChecked || (checked ?? false);
//
//     if (onSelectAll != null) {
//       onSelectAll!(effectiveChecked);
//     } else {
//       for (final DataRow row in rows) {
//         if (row.onSelectChanged != null && row.selected != effectiveChecked) {
//           row.onSelectChanged!(effectiveChecked);
//         }
//       }
//     }
//   }
//
//   (double, double) getMinMaxRowHeight(BuildContext context) {
//     ///TODO add to theming data row min height.
//     final double effectiveDataRowMinHeight = dataRowHeight ?? 48;
//
//     return (effectiveDataRowMinHeight, effectiveDataRowMinHeight);
//   }
//
//   Widget _buildCheckbox({
//     required BuildContext context,
//     required bool? checked,
//     required VoidCallback? onRowTap,
//     required ValueChanged<bool?>? onCheckboxChanged,
//     required MaterialStateProperty<Color?>? overlayColor,
//     required bool tristate,
//     required double? rowHeight,
//   }) {
//     /// TODO add to theming horizontal checkbox margin.
//     final double effectiveHorizontalMargin = horizontalMargin ?? 8;
//
//     final (effectiveDataRowMinHeight, effectiveDataRowMaxHeight) = getMinMaxRowHeight(context);
//
//     /// TODO overlay color cannot be given moonColor. Override.
//
//     Widget wrapInContainer(Widget child) => Container(
//           alignment: checkboxAlignment,
//           constraints: BoxConstraints(
//             minHeight: rowHeight ?? effectiveDataRowMinHeight,
//             maxHeight: rowHeight ?? effectiveDataRowMaxHeight,
//           ),
//           padding: EdgeInsetsDirectional.only(
//             start: checkboxHorizontalMargin ?? effectiveHorizontalMargin,
//             end: (checkboxHorizontalMargin ?? effectiveHorizontalMargin) / 2.0,
//           ),
//           child: child,
//         );
//
//     Widget checkbox = Semantics(
//       container: true,
//       child: wrapInContainer(
//         MoonCheckbox(
//           value: checked,
//           onChanged: onCheckboxChanged,
//           tristate: tristate,
//         ),
//       ),
//     );
//
//     ///TODO think solution how to color the row when checkbox tapped.
//     // if (onRowTap != null) {
//     //   checkbox = TableRowInkWell(
//     //     onTap: onRowTap,
//     //     overlayColor: overlayColor,
//     //     child: checkbox,
//     //   );
//     // }
//
//     return checkbox;
//   }
//
//   Widget _buildHeadingCell({
//     required BuildContext context,
//     required bool isLastCell,
//     required bool ascending,
//     required bool numeric,
//     required bool sorted,
//     required double effectiveHeadingRowHeight,
//     required EdgeInsetsGeometry padding,
//     required String? tooltip,
//     required MaterialStateProperty<Color?>? overlayColor,
//     required VoidCallback? onSort,
//     required Widget label,
//   }) {
//     ///TODO theming!
//     final customArrows = sortArrowBuilder?.call(ascending, sorted);
//     final TextStyle effectiveHeadingTextStyle =
//         headingTextStyle ?? context.moonTypography!.heading.textDefault.copyWith(color: MoonColors.light.textPrimary);
//
//     Widget labelWidget = label;
//
//     labelWidget = Row(
//       textDirection: numeric ? TextDirection.rtl : null,
//       children: <Widget>[
//         Flexible(child: labelWidget),
//         if (onSort != null) ...<Widget>[
//           customArrows ??
//               _SortArrow(
//                 visible: sorted,
//                 up: sorted ? ascending : null,
//                 duration: sortArrowAnimationDuration,
//                 sortArrowIcon: sortArrowIcon,
//               ),
//           const SizedBox(width: _sortArrowPadding),
//           if (showHeaderDivider && !isLastCell)
//
//             /// TODO This is the vertical divider between cells. Add to props! vertical margin, color, width!
//             Expanded(
//               child: Container(
//                 margin: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       width: 1,
//                       color: context.moonColors!.beerus,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//         ],
//       ],
//     );
//
//     labelWidget = Container(
//       padding: padding,
//       height: effectiveHeadingRowHeight,
//       alignment: numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
//       child: DefaultTextStyle(
//         style: effectiveHeadingTextStyle,
//         softWrap: false,
//         child: labelWidget,
//       ),
//     );
//
//     /// TODO use MoonTooltip?
//     if (tooltip != null) {
//       labelWidget = Tooltip(
//         message: tooltip,
//         child: labelWidget,
//       );
//     }
//
//     ///TODO detect hover and change color/cursor.
//     return GestureDetector(
//       onTap: onSort,
//       child: labelWidget,
//     );
//   }
//
//   Widget _buildDataCell({
//     required BuildContext context,
//     required bool isGapRowCell,
//     required bool isLastCell,
//     required bool numeric,
//     required bool placeholder,
//     required bool showEditIcon,
//     required double? specificRowHeight,
//     required EdgeInsetsGeometry padding,
//     required GestureTapCallback? onTap,
//     required GestureTapCallback? onDoubleTap,
//     required GestureLongPressCallback? onLongPress,
//     required GestureTapDownCallback? onTapDown,
//     required GestureTapCancelCallback? onTapCancel,
//     required GestureTapCallback? onRowTap,
//     required GestureTapCallback? onRowDoubleTap,
//     required GestureLongPressCallback? onRowLongPress,
//     required GestureTapCallback? onRowSecondaryTap,
//     required GestureTapDownCallback? onRowSecondaryTapDown,
//     required VoidCallback? onSelectChanged,
//     required Widget label,
//     required MaterialStateProperty<Color?>? overlayColor,
//   }) {
//     final TextStyle effectiveDataTextStyle =
//         dataTextStyle ?? context.moonTypography!.body.textDefault.copyWith(color: MoonColors.light.textPrimary);
//
//     Widget labelWidget = label;
//
//     /// do we need edit? remove TODO
//     if (showEditIcon) {
//       const Widget icon = Icon(Icons.edit, size: 18.0);
//
//       labelWidget = Expanded(child: labelWidget);
//
//       labelWidget = Row(
//         textDirection: numeric ? TextDirection.rtl : null,
//         children: <Widget>[labelWidget, icon],
//       );
//     }
//
//     final (effectiveDataRowMinHeight, effectiveDataRowMaxHeight) = getMinMaxRowHeight(context);
//     final resolvedPadding = showCellDivider && !isLastCell
//         ? EdgeInsetsDirectional.only(
//             start: padding.horizontal / 2,
//             top: padding.vertical / 2,
//             bottom: padding.vertical / 2,
//           )
//         : padding;
//
//     if (isGapRowCell) return SizedBox(height: specificRowHeight);
//
//     labelWidget = Container(
//       padding: resolvedPadding,
//       constraints: BoxConstraints(
//         minHeight: specificRowHeight ?? effectiveDataRowMinHeight,
//         maxHeight: specificRowHeight ?? effectiveDataRowMaxHeight,
//       ),
//       alignment: numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
//       child: DefaultTextStyle(
//         style: effectiveDataTextStyle.copyWith(
//           color: placeholder ? effectiveDataTextStyle.color!.withOpacity(0.6) : null,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: Row(
//             children: [
//               labelWidget,
//               if (showCellDivider && !isLastCell)
//
//                 /// TODO This is the vertical divider between cells. Add to props! vertical margin, color, width!
//                 Expanded(
//                   child: Container(
//                     margin: EdgeInsetsDirectional.only(start: padding.horizontal / 2, top: 12, bottom: 12),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         right: BorderSide(
//                           width: 1,
//                           color: context.moonColors!.beerus,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//
//     /// wrap with MoonBaseControl? TODO
//     // Wrap label with InkResponse if there are cell or row level tap events
//     if (onTap != null || onDoubleTap != null || onLongPress != null || onTapDown != null || onTapCancel != null) {
//       // cell level
//       labelWidget = InkWell(
//         onTap: () {
//           onTap?.call();
//           onRowTap?.call();
//         },
//         onDoubleTap: () {
//           onDoubleTap?.call();
//           onRowDoubleTap?.call();
//         },
//         onLongPress: () {
//           onLongPress?.call();
//           onRowLongPress?.call();
//         },
//         onTapDown: onTapDown,
//         onTapCancel: onTapCancel,
//         onSecondaryTap: onRowSecondaryTap,
//         onSecondaryTapDown: onRowSecondaryTapDown,
//         overlayColor: overlayColor,
//         child: labelWidget,
//       );
//     } else if (onSelectChanged != null ||
//         onRowTap != null ||
//         onRowDoubleTap != null ||
//         onRowLongPress != null ||
//         onRowSecondaryTap != null ||
//         onRowSecondaryTapDown != null) {
//       // row level
//       labelWidget = TableRowInkWell(
//         onTap: onRowTap ?? onSelectChanged,
//         onDoubleTap: onRowDoubleTap,
//         onLongPress: onRowLongPress,
//         onSecondaryTap: onRowSecondaryTap,
//         onSecondaryTapDown: onRowSecondaryTapDown,
//         overlayColor: overlayColor,
//         child: labelWidget,
//       );
//     }
//     return labelWidget;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMaterial(context));
//
//     final theme = Theme.of(context);
//     final effectiveHeadingRowColor = headingRowColor ?? theme.dataTableTheme.headingRowColor;
//     final effectiveDataRowColor = dataRowColor ?? theme.dataTableTheme.dataRowColor;
//     final defaultRowColor = MaterialStateProperty.resolveWith(
//       (Set<MaterialState> states) {
//         if (states.contains(MaterialState.selected)) theme.colorScheme.primary.withOpacity(0.08);
//         return null;
//       },
//     );
//     final anyRowSelectable = rows.any((DataRow row) => row.onSelectChanged != null);
//     final displayCheckboxColumn = showCheckboxColumn && anyRowSelectable;
//     final rowsWithCheckbox =
//         displayCheckboxColumn ? rows.where((DataRow row) => row.onSelectChanged != null) : <MoonDataRow>[];
//     final rowsChecked = rowsWithCheckbox.where((DataRow row) => row.selected);
//     final allChecked = displayCheckboxColumn && rowsChecked.length == rowsWithCheckbox.length;
//     final anyChecked = displayCheckboxColumn && rowsChecked.isNotEmpty;
//     final someChecked = anyChecked && !allChecked;
//     final effectiveHorizontalMargin = horizontalMargin ?? theme.dataTableTheme.horizontalMargin ?? _horizontalMargin;
//     final effectiveColumnSpacing = columnSpacing ?? theme.dataTableTheme.columnSpacing ?? _columnSpacing;
//
//     final double effectiveHeadingRowHeight =
//         headingRowHeight ?? theme.dataTableTheme.headingRowHeight ?? _headingRowHeight;
//
//     final tableColumnWidths =
//         List<TableColumnWidth>.filled(columns.length + (displayCheckboxColumn ? 1 : 0), const _NullTableColumnWidth());
//
//     final headingRow = _buildHeadingRow(context, theme, effectiveHeadingRowColor, tableColumnWidths.length);
//
//     final actualFixedRows = max(0, rows.isEmpty ? 0 : min(fixedTopRows * 2 - 1, rows.length + 1));
//
//     final actualFixedColumns =
//         max(0, rows.isEmpty ? 0 : min(fixedLeftColumns, columns.length + (showCheckboxColumn ? 1 : 0)));
//
//     final List<TableRow>? coreRows = rows.isEmpty || actualFixedColumns >= columns.length + (showCheckboxColumn ? 1 : 0)
//         ? null
//         : _buildTableRows(
//             anyRowSelectable,
//             effectiveDataRowColor,
//             context,
//             theme,
//             tableColumnWidths.length - actualFixedColumns,
//             defaultRowColor,
//             actualFixedRows == 0
//                 ? _buildHeadingRow(
//                     context,
//                     theme,
//                     effectiveHeadingRowColor,
//                     tableColumnWidths.length - actualFixedColumns,
//                   )
//                 : null,
//             actualFixedRows > 0 ? actualFixedRows - 1 : 0,
//           );
//
//     final List<TableRow>? fixedColumnsRows = rows.isEmpty
//         ? null
//         : actualFixedColumns > 0
//             ? (actualFixedRows < 1
//                 ? [
//                     _buildHeadingRow(
//                       context,
//                       theme,
//                       fixedColumnsColor != null
//                           ? MaterialStatePropertyAll(fixedColumnsColor)
//                           : effectiveHeadingRowColor,
//                       actualFixedColumns,
//                     ),
//                     ..._buildTableRows(
//                       anyRowSelectable,
//                       fixedColumnsColor != null ? MaterialStatePropertyAll(fixedColumnsColor) : effectiveDataRowColor,
//                       context,
//                       theme,
//                       actualFixedColumns,
//                       defaultRowColor,
//                       null,
//                       0,
//                       0,
//                       true,
//                     )
//                   ]
//                 : _buildTableRows(
//                     anyRowSelectable,
//                     fixedColumnsColor != null ? MaterialStatePropertyAll(fixedColumnsColor) : effectiveDataRowColor,
//                     context,
//                     theme,
//                     actualFixedColumns,
//                     defaultRowColor,
//                     null,
//                     actualFixedRows - 1,
//                     0,
//                     true,
//                   ))
//             : null;
//
//     final List<TableRow>? fixedRows = actualFixedRows > 0
//         ? (actualFixedRows == 1
//             ? [
//                 _buildHeadingRow(
//                   context,
//                   theme,
//                   headingRowColor ?? effectiveHeadingRowColor,
//                   tableColumnWidths.length - actualFixedColumns,
//                 )
//               ]
//             : [
//                 _buildHeadingRow(
//                   context,
//                   theme,
//                   headingRowColor ?? effectiveHeadingRowColor,
//                   tableColumnWidths.length - actualFixedColumns,
//                 ),
//                 ..._buildTableRows(
//                   anyRowSelectable,
//                   headingRowColor ?? effectiveDataRowColor,
//                   context,
//                   theme,
//                   tableColumnWidths.length - actualFixedColumns,
//                   defaultRowColor,
//                   null,
//                   0,
//                   actualFixedRows - 1,
//                   true,
//                 )
//               ])
//         : null;
//
//     final List<TableRow>? fixedCornerRows = actualFixedColumns > 0 && actualFixedRows > 0
//         ? (actualFixedRows == 1
//             ? [
//                 _buildHeadingRow(
//                   context,
//                   theme,
//                   fixedCornerColor != null ? MaterialStatePropertyAll(fixedCornerColor) : effectiveHeadingRowColor,
//                   actualFixedColumns,
//                 )
//               ]
//             : [
//                 _buildHeadingRow(
//                   context,
//                   theme,
//                   fixedCornerColor != null ? MaterialStatePropertyAll(fixedCornerColor) : effectiveHeadingRowColor,
//                   actualFixedColumns,
//                 ),
//                 ..._buildTableRows(
//                   anyRowSelectable,
//                   fixedCornerColor != null ? MaterialStatePropertyAll(fixedCornerColor) : effectiveDataRowColor,
//                   context,
//                   theme,
//                   actualFixedColumns,
//                   defaultRowColor,
//                   null,
//                   0,
//                   actualFixedRows - 1,
//                   true,
//                 )
//               ])
//         : null;
//
//     final double checkBoxWidth = _addCheckBoxes(
//       displayCheckboxColumn,
//       effectiveHorizontalMargin,
//       tableColumnWidths,
//       headingRow,
//       effectiveHeadingRowHeight,
//       context,
//       someChecked,
//       allChecked,
//       coreRows,
//       fixedRows,
//       fixedCornerRows,
//       fixedColumnsRows,
//       rows,
//       actualFixedRows,
//       effectiveDataRowColor,
//     );
//
//     final builder = LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return SyncedScrollControllers(
//           verticalController: scrollController,
//           horizontalController: horizontalScrollController,
//           builder: (
//             context,
//             verticalController,
//             fixedVerticalController,
//             horizontalController,
//             fixedHorizontalController,
//           ) {
//             final coreVerticalController = verticalController;
//             final coreHorizontalController = horizontalController;
//             final leftColumnVerticalController = fixedVerticalController;
//             final fixedRowsHorizontalController = fixedHorizontalController;
//
//             int displayColumnIndex = 0;
//
//             if (checkBoxWidth > 0) displayColumnIndex += 1;
//
//             // Column sizes are fixed for fixed columns.
//             final List<double> widths =
//                 _calculateDataColumnSizes(constraints, checkBoxWidth, effectiveHorizontalMargin);
//
//             // Fill row empty cells with actual widgets.
//             for (int dataColumnIndex = 0; dataColumnIndex < columns.length; dataColumnIndex++) {
//               final DataColumn column = columns[dataColumnIndex];
//
//               final double paddingStart = dataColumnIndex == 0
//                   ? displayCheckboxColumn
//                       ? effectiveHorizontalMargin / 2.0
//                       : effectiveHorizontalMargin
//                   : effectiveColumnSpacing / 2.0;
//
//               final double paddingEnd =
//                   dataColumnIndex == columns.length - 1 ? effectiveHorizontalMargin : effectiveColumnSpacing / 2.0;
//
//               final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(start: paddingStart, end: paddingEnd);
//
//               tableColumnWidths[displayColumnIndex] = FixedColumnWidth(widths[dataColumnIndex]);
//
//               // Build heading row cell.
//               final headingCell = _buildHeadingCell(
//                 context: context,
//                 isLastCell: dataColumnIndex == columns.length - 1,
//                 padding: padding,
//                 effectiveHeadingRowHeight: effectiveHeadingRowHeight,
//                 label: column.label,
//                 tooltip: column.tooltip,
//                 numeric: column.numeric,
//                 sorted: dataColumnIndex == sortColumnIndex,
//                 ascending: sortAscending,
//                 overlayColor: effectiveHeadingRowColor,
//                 onSort: column.onSort != null
//                     ? () => column.onSort!(dataColumnIndex, sortColumnIndex != dataColumnIndex || !sortAscending)
//                     : null,
//               );
//
//               headingRow.children[displayColumnIndex] = headingCell;
//
//               if (displayColumnIndex < actualFixedColumns) {
//                 if (actualFixedRows < 1) {
//                   fixedColumnsRows![0].children[displayColumnIndex] = headingCell;
//                 } else if (actualFixedRows > 0) {
//                   fixedCornerRows![0].children[displayColumnIndex] = headingCell;
//                 }
//               } else {
//                 if (actualFixedRows < 1 && coreRows != null) {
//                   coreRows[0].children[displayColumnIndex - actualFixedColumns] = headingCell;
//                 } else if (actualFixedRows > 0) {
//                   fixedRows![0].children[displayColumnIndex - actualFixedColumns] = headingCell;
//                 }
//               }
//
//               // Build body row cell.
//               int rowIndex = 0;
//
//               final skipRows = actualFixedRows == 1
//                   ? 0
//                   : actualFixedRows > 1
//                       ? actualFixedRows - 1
//                       : -1;
//
//               for (final DataRow row in rows) {
//                 final DataCell dataCell = row.cells[dataColumnIndex];
//
//                 final cell = _buildDataCell(
//                   isGapRowCell: rowIndex.isOdd,
//                   isLastCell: dataColumnIndex == row.cells.length - 1,
//                   context: context,
//                   padding: padding,
//                   specificRowHeight: row is MoonDataRow ? row.rowHeight : null,
//                   label: dataCell.child,
//                   numeric: column.numeric,
//                   placeholder: dataCell.placeholder,
//                   showEditIcon: dataCell.showEditIcon,
//                   onTap: dataCell.onTap,
//                   onDoubleTap: dataCell.onDoubleTap,
//                   onLongPress: dataCell.onLongPress,
//                   onTapDown: dataCell.onTapDown,
//                   onTapCancel: dataCell.onTapCancel,
//                   onRowTap: row is MoonDataRow ? row.onTap : null,
//                   onRowDoubleTap: row is MoonDataRow ? row.onDoubleTap : null,
//                   onRowLongPress: row.onLongPress,
//                   onRowSecondaryTap: row is MoonDataRow ? row.onSecondaryTap : null,
//                   onRowSecondaryTapDown: row is MoonDataRow ? row.onSecondaryTapDown : null,
//                   onSelectChanged: row.onSelectChanged != null ? () => row.onSelectChanged!(!row.selected) : null,
//                   overlayColor: row.color ?? effectiveDataRowColor,
//                 );
//
//                 if (displayColumnIndex < actualFixedColumns) {
//                   if (rowIndex + 1 < actualFixedRows) {
//                     fixedCornerRows![rowIndex + 1].children[displayColumnIndex] = cell;
//                   } else {
//                     fixedColumnsRows![rowIndex - skipRows].children[displayColumnIndex] = cell;
//                   }
//                 } else {
//                   if (rowIndex + 1 < actualFixedRows) {
//                     fixedRows![rowIndex + 1].children[displayColumnIndex - actualFixedColumns] = cell;
//                   } else {
//                     coreRows![rowIndex - skipRows].children[displayColumnIndex - actualFixedColumns] = cell;
//                   }
//                 }
//
//                 rowIndex += 1;
//               }
//               displayColumnIndex += 1;
//             }
//
//             // Build data table
//             final Map<int, TableColumnWidth> widthsAsMap = tableColumnWidths.asMap();
//
//             final Map<int, TableColumnWidth>? leftWidthsAsMap =
//                 actualFixedColumns > 0 ? tableColumnWidths.take(actualFixedColumns).toList().asMap() : null;
//
//             final Map<int, TableColumnWidth>? rightWidthsAsMap =
//                 actualFixedColumns > 0 ? tableColumnWidths.skip(actualFixedColumns).toList().asMap() : null;
//
//             bool isRowsEmpty(List<TableRow>? rows) => rows == null || rows.isEmpty || rows[0].children.isEmpty;
//
//             final coreTable = Table(
//               columnWidths: actualFixedColumns > 0 ? rightWidthsAsMap : widthsAsMap,
//               children: coreRows ?? [],
//               border: border == null
//                   ? null
//                   : isRowsEmpty(fixedRows) && isRowsEmpty(fixedColumnsRows)
//                       ? border
//                       : !isRowsEmpty(fixedRows) && !isRowsEmpty(fixedColumnsRows)
//                           ? TableBorder(
//                               right: border!.right,
//                               bottom: border!.bottom,
//                               verticalInside: border!.verticalInside,
//                               horizontalInside: border!.horizontalInside,
//                               borderRadius: border!.borderRadius,
//                             )
//                           : isRowsEmpty(fixedRows)
//                               ? TableBorder(
//                                   top: border!.top,
//                                   right: border!.right,
//                                   bottom: border!.bottom,
//                                   verticalInside: border!.verticalInside,
//                                   horizontalInside: border!.horizontalInside,
//                                   borderRadius: border!.borderRadius,
//                                 )
//                               : TableBorder(
//                                   left: border!.left,
//                                   right: border!.right,
//                                   bottom: border!.bottom,
//                                   verticalInside: border!.verticalInside,
//                                   horizontalInside: border!.horizontalInside,
//                                   borderRadius: border!.borderRadius,
//                                 ),
//             );
//
//             Table? fixedRowsTable;
//             Table? fixedColumnsTable;
//             Table? fixedTopLeftCornerTable;
//             Widget? fixedColumnAndCornerColumn;
//             Widget? fixedRowsAndCoreColumns;
//
//             if (rows.isNotEmpty) {
//               if (fixedRows != null &&
//                   !isRowsEmpty(fixedRows) &&
//                   actualFixedColumns < columns.length + (showCheckboxColumn ? 1 : 0)) {
//                 fixedRowsTable = Table(
//                   columnWidths: actualFixedColumns > 0 ? rightWidthsAsMap : widthsAsMap,
//                   children: fixedRows,
//                   border: border == null
//                       ? null
//                       : isRowsEmpty(fixedCornerRows)
//                           ? border
//                           : TableBorder(
//                               top: border!.top,
//                               right: border!.right,
//                               bottom: border!.bottom,
//                               verticalInside: border!.verticalInside,
//                               horizontalInside: border!.horizontalInside,
//                               borderRadius: border!.borderRadius,
//                             ),
//                 );
//               }
//
//               if (fixedColumnsRows != null && !isRowsEmpty(fixedColumnsRows)) {
//                 fixedColumnsTable = Table(
//                   columnWidths: leftWidthsAsMap,
//                   children: fixedColumnsRows,
//                   border: border == null
//                       ? null
//                       : isRowsEmpty(fixedCornerRows)
//                           ? border
//                           : TableBorder(
//                               left: border!.left,
//                               right: border!.right,
//                               bottom: border!.bottom,
//                               verticalInside: border!.verticalInside,
//                               horizontalInside: border!.horizontalInside,
//                               borderRadius: border!.borderRadius,
//                             ),
//                 );
//               }
//
//               if (fixedCornerRows != null && !isRowsEmpty(fixedCornerRows)) {
//                 fixedTopLeftCornerTable =
//                     Table(columnWidths: leftWidthsAsMap, children: fixedCornerRows, border: border);
//               }
//
//               Widget addBottomMargin(Table table) => bottomMargin != null && bottomMargin! > 0
//                   ? Column(mainAxisSize: MainAxisSize.min, children: [table, SizedBox(height: bottomMargin)])
//                   : table;
//
//               // Cupertino ignores themes for scrollbar, so we need to manually apply it.
//               final scrollBarTheme = Theme.of(context).scrollbarTheme;
//               final isiOS = Theme.of(context).platform == TargetPlatform.iOS;
//
//               final disableHorizontalScrollBar =
//                   isiOS && isHorizontalScrollBarVisible != null && !isHorizontalScrollBarVisible!;
//
//               final disableVerticalScrollBar =
//                   isiOS && isVerticalScrollBarVisible != null && !isVerticalScrollBarVisible!;
//
//               // For iOS/Cupertino scrollbar
//               fixedRowsAndCoreColumns = Scrollbar(
//                 thumbVisibility: isHorizontalScrollBarVisible ??
//                     (isiOS ? scrollBarTheme.thumbVisibility?.resolve({MaterialState.hovered}) : null),
//                 thickness: disableHorizontalScrollBar
//                     ? 0
//                     : (isiOS ? scrollBarTheme.thickness?.resolve({MaterialState.hovered}) : null),
//                 controller: coreHorizontalController,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ScrollConfiguration(
//                       behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//                       child: SingleChildScrollView(
//                         controller: fixedRowsHorizontalController,
//                         scrollDirection: Axis.horizontal,
//                         child: (fixedRowsTable != null)
//                             ? fixedRowsTable
//                             // Workaround for a bug when there's no horizontal scrollbar.
//                             : SizedBox(
//                                 height: 0,
//                                 width: widths.fold<double>(0, (previousValue, value) => previousValue + value),
//                               ),
//                       ),
//                     ),
//                     Flexible(
//                       fit: FlexFit.tight,
//                       child: Scrollbar(
//                         thumbVisibility: isVerticalScrollBarVisible ??
//                             (isiOS ? scrollBarTheme.thumbVisibility?.resolve({MaterialState.hovered}) : null),
//                         thickness: disableVerticalScrollBar
//                             ? 0
//                             : (isiOS ? scrollBarTheme.thickness?.resolve({MaterialState.hovered}) : 0),
//                         controller: coreVerticalController,
//                         child: SingleChildScrollView(
//                           controller: coreVerticalController,
//                           child: SingleChildScrollView(
//                             controller: coreHorizontalController,
//                             scrollDirection: Axis.horizontal,
//                             child: addBottomMargin(coreTable),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//
//               fixedColumnAndCornerColumn = fixedTopLeftCornerTable == null && fixedColumnsTable == null
//                   ? null
//                   : Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (fixedTopLeftCornerTable != null) fixedTopLeftCornerTable,
//                         if (fixedColumnsTable != null)
//                           Flexible(
//                             child: ScrollConfiguration(
//                               behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
//                               child: SingleChildScrollView(
//                                 controller: leftColumnVerticalController,
//                                 child: addBottomMargin(fixedColumnsTable),
//                               ),
//                             ),
//                           )
//                       ],
//                     );
//             }
//
//             final finalTableWidget = Container(
//               decoration: decoration ?? theme.dataTableTheme.decoration,
//               child: Material(
//                 type: MaterialType.transparency,
//                 borderRadius: border?.borderRadius,
//                 clipBehavior: clipBehavior,
//                 child: rows.isEmpty
//                     ? Column(
//                         children: [
//                           SingleChildScrollView(
//                             controller: coreHorizontalController,
//                             scrollDirection: Axis.horizontal,
//                             child: Table(columnWidths: widthsAsMap, border: border, children: [headingRow]),
//                           ),
//                           Flexible(fit: FlexFit.tight, child: placeHolder ?? const SizedBox())
//                         ],
//                       )
//                     : Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (fixedColumnAndCornerColumn != null) fixedColumnAndCornerColumn,
//                           if (fixedRowsAndCoreColumns != null)
//                             Flexible(fit: FlexFit.tight, child: fixedRowsAndCoreColumns)
//                         ],
//                       ),
//               ),
//             );
//
//             return finalTableWidget;
//           },
//         );
//       },
//     );
//
//     return builder;
//   }
//
//   double _addCheckBoxes(
//     bool displayCheckboxColumn,
//     double effectiveHorizontalMargin,
//     List<TableColumnWidth> tableColumns,
//     TableRow headingRow,
//     double headingHeight,
//     BuildContext context,
//     bool someChecked,
//     bool allChecked,
//     List<TableRow>? coreRows,
//     List<TableRow>? fixedRows,
//     List<TableRow>? fixedCornerRows,
//     List<TableRow>? fixedColumnRows,
//     List<DataRow> rows,
//     int actualFixedRows,
//     MaterialStateProperty<Color?>? effectiveDataRowColor,
//   ) {
//     double checkBoxWidth = 0;
//
//     if (displayCheckboxColumn) {
//       checkBoxWidth = effectiveHorizontalMargin + Checkbox.width + effectiveHorizontalMargin / 2.0;
//       tableColumns[0] = FixedColumnWidth(checkBoxWidth);
//
//       // Create heading twice, in the heading row used as back-up for the case of no data and any of the x rows table.
//       headingRow.children[0] = _buildCheckbox(
//         context: context,
//         checked: someChecked ? null : allChecked,
//         onRowTap: null,
//         onCheckboxChanged: (bool? checked) => _handleSelectAll(checked, someChecked),
//         overlayColor: null,
//         tristate: true,
//         rowHeight: headingHeight,
//       );
//
//       if (fixedCornerRows != null) {
//         fixedCornerRows[0].children[0] = headingRow.children[0];
//       } else if (fixedColumnRows != null) {
//         fixedColumnRows[0].children[0] = headingRow.children[0];
//       } else if (fixedRows != null) {
//         fixedRows[0].children[0] = headingRow.children[0];
//       } else {
//         coreRows![0].children[0] = headingRow.children[0];
//       }
//
//       final skipRows = actualFixedRows == 1
//           ? 0
//           : actualFixedRows > 1
//               ? actualFixedRows - 1
//               : -1;
//
//       var rowIndex = 0;
//       for (final DataRow row in rows) {
//         final checkBox = rowIndex.isOdd
//             ? const SizedBox()
//             : _buildCheckbox(
//                 context: context,
//                 checked: row.selected,
//                 onRowTap: () {
//                   if (row is MoonDataRow && row.onTap != null) {
//                     row.onTap?.call();
//                   } else {
//                     row.onSelectChanged?.call(!row.selected);
//                   }
//                 },
//                 onCheckboxChanged: row.onSelectChanged,
//                 overlayColor: row.color ?? effectiveDataRowColor,
//                 tristate: false,
//                 rowHeight: rows[rowIndex] is MoonDataRow ? (rows[rowIndex] as MoonDataRow).rowHeight : null,
//               );
//
//         if (fixedCornerRows != null && rowIndex < fixedCornerRows.length - 1) {
//           fixedCornerRows[rowIndex + 1].children[0] = checkBox;
//         } else if (fixedColumnRows != null) {
//           fixedColumnRows[rowIndex - skipRows].children[0] = checkBox;
//         } else if (fixedRows != null && rowIndex < fixedRows.length - 1) {
//           fixedRows[rowIndex + 1].children[0] = checkBox;
//         } else {
//           coreRows![rowIndex - skipRows].children[0] = checkBox;
//         }
//
//         rowIndex += 1;
//       }
//     }
//     return checkBoxWidth;
//   }
//
//   /// Check if needed at all!! Maybe can remove. TODO
//   List<double> _calculateDataColumnSizes(
//     BoxConstraints constraints,
//     double checkBoxWidth,
//     double effectiveHorizontalMargin,
//   ) {
//     double totalColCalculatedWidth = 0.0;
//     double totalColAvailableWidth = constraints.maxWidth;
//     final columnWidth = totalColAvailableWidth / columns.length;
//
//     if (minTableWidth != null && totalColAvailableWidth < minTableWidth!) totalColAvailableWidth = minTableWidth!;
//
//     // If no check box column is present, add full margin to the left and right.
//     // If check box column is present, add half margin to the left and full margin to the right.
//     totalColAvailableWidth = totalColAvailableWidth -
//         checkBoxWidth -
//         effectiveHorizontalMargin -
//         (checkBoxWidth > 0 ? effectiveHorizontalMargin / 2 : effectiveHorizontalMargin);
//
//     final totalFixedWidth = columns.fold<double>(
//       0.0,
//       (previousValue, element) =>
//           previousValue + (element is MoonDataColumn && element.fixedWidth != null ? element.fixedWidth! : 0.0),
//     );
//
//     assert(
//       totalFixedWidth < totalColAvailableWidth,
//       "Combined width of columns of fixed width is greater than available parent width. Table will be clipped",
//     );
//
//     totalColAvailableWidth = max(0.0, totalColAvailableWidth - totalFixedWidth);
//
//     final widths = List<double>.generate(columns.length, (int index) {
//       final column = columns[index];
//       double width = columnWidth;
//
//       if (column is MoonDataColumn) {
//         if (column.fixedWidth != null) width = column.fixedWidth!;
//       }
//
//       // Skip fixed width columns.
//       if (!(column is MoonDataColumn && column.fixedWidth != null)) totalColCalculatedWidth += width;
//
//       return width;
//     });
//
//     // Scale columns to fit the total width into available width.
//     final ratio = totalColAvailableWidth / totalColCalculatedWidth;
//
//     // Skip fixed width column
//     for (var i = 0; i < widths.length; i++) {
//       if (!(columns[i] is MoonDataColumn && (columns[i] as MoonDataColumn).fixedWidth != null)) widths[i] *= ratio;
//     }
//
//     // Add margins to side columns.
//     if (widths.length == 1) {
//       widths[0] = max(
//         0,
//         widths[0] +
//             effectiveHorizontalMargin +
//             (checkBoxWidth > 0 ? effectiveHorizontalMargin / 2 : effectiveHorizontalMargin),
//       );
//     } else if (widths.length > 1) {
//       widths[0] =
//           max(0, widths[0] + (checkBoxWidth > 0 ? effectiveHorizontalMargin / 2 : effectiveHorizontalMargin));
//       widths[widths.length - 1] = max(0, widths[widths.length - 1] + effectiveHorizontalMargin);
//     }
//
//     return widths;
//   }
//
//   List<TableRow> _buildTableRows(
//     bool anyRowSelectable,
//     MaterialStateProperty<Color?>? effectiveDataRowColor,
//     BuildContext context,
//     ThemeData theme,
//     int numberOfCols,
//     MaterialStateProperty<Color?> defaultRowColor,
//     TableRow? headingRow, [
//     int skipRows = 0,
//     int takeRows = 0,
//     bool forceEffectiveDataRowColor = false,
//   ]) {
//     final int rowStartIndex = skipRows;
//     final int rowsToGenerate = (takeRows <= 0 ? rows.length - skipRows : takeRows) + (headingRow == null ? 0 : 1);
//     final int startIndexForCoreRows = max(skipRows, takeRows);
//
//     print('rowsToGenerate: $rowsToGenerate');
//
//     /// should be dataRowColor, but its type needs to be changed.
//     final Color zebraRowBackgroundColor = evenRowColor ?? Colors.transparent;
//     bool zebraRow = true;
//
//     final List<TableRow> tableRows = List<TableRow>.generate(
//       rowsToGenerate,
//       (int index) {
//         final int actualIndex = headingRow == null ? index : index - 1;
//
//         if (headingRow != null && index == 0) {
//           return headingRow;
//         } else {
//           if (rows[rowStartIndex + actualIndex].key == _spacerRowKey) {
//             return TableRow(
//               children: List<Widget>.filled(numberOfCols, const _NullWidget()),
//             );
//           }
//
//           print('startIndexforCoreRows: $startIndexForCoreRows, actualIndex: $actualIndex');
//
//           final TableRow tableRow = TableRow(
//             key: rows[rowStartIndex + actualIndex].key,
//             decoration: ShapeDecorationWithPremultipliedAlpha(
//               // color:  rows[rowStartIndex + actualIndex].color == null ? Colors.pink : Colors.transparent,
//               color: effectiveDataRowColor?.resolve(<MaterialState>{}),
//               // zebraRow ? zebraRowBackgroundColor : Colors.transparent,
//               // shape: MoonSquircleBorder(
//               //   side: BorderSide(
//               //     color: Colors.black,
//               //     width: 1,
//               //   ),
//               //   borderRadius: MoonSquircleBorderRadius.only(
//               //     topLeft: const MoonSquircleRadius(cornerRadius: 8),
//               //     bottomLeft: const MoonSquircleRadius(cornerRadius: 8),
//               //     topRight: MoonSquircleRadius(cornerRadius: fixedLeftColumns > 0 ? 0 : 8),
//               //     bottomRight: MoonSquircleRadius(cornerRadius: fixedLeftColumns > 0 ? 0 : 8),
//               //   ),
//               // ),
//               shape: MoonSquircleBorder(
//                 borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
//                 side: const BorderSide(
//                   color: Colors.transparent,
//                   width: 1,
//                 ),
//               ),
//             ),
//             children: List<Widget>.filled(numberOfCols, const _NullWidget()),
//           );
//
//           // rowsToGenerate < actualIndex  ? zebraRowForCore = !zebraRowForCore : zebraRowForFixed = !zebraRowForFixed;
//           zebraRow = !zebraRow;
//           return tableRow;
//         }
//       },
//       //
//       //   if (headingRow != null && index == 0) {
//       //     return headingRow;
//       //   } else {
//       //     // final bool isSelected = rows[rowStartIndex + actualIndex].selected;
//       //     // final bool isDisabled = anyRowSelectable && rows[rowStartIndex + actualIndex].onSelectChanged == null;
//       //     // final Set<MaterialState> states = <MaterialState>{
//       //     //   if (isSelected) MaterialState.selected,
//       //     //   if (isDisabled) MaterialState.disabled,
//       //     // };
//       //     // final Color? resolvedDataRowColor = (forceEffectiveDataRowColor
//       //     //         ? effectiveDataRowColor
//       //     //         : (rows[rowStartIndex + actualIndex].color ?? effectiveDataRowColor))
//       //     //     ?.resolve(states);
//       //     // final Color? rowColor = resolvedDataRowColor;
//       //     // final BorderSide borderSide = Divider.createBorderSide(
//       //     //   context,
//       //     //   width: dividerThickness ?? theme.dataTableTheme.dividerThickness ?? _dividerThickness,
//       //     // );
//       //     // final Border border = showBottomBorder ? Border(bottom: borderSide) : Border(top: borderSide);
//       //      return index.isEven ?
//       //      TableRow(
//       //       key: rows[rowStartIndex + derivedIndex].key,
//       //       // decoration: BoxDecoration(
//       //       //   // Changed standard behaviour to never add border should the thickness be 0
//       //       //   border: dividerThickness == null || (dividerThickness != null && dividerThickness != 0.0) ? border : null,
//       //       //   color: rowColor ?? defaultRowColor.resolve(states),
//       //       // ),
//       //       ///
//       //       /// Propertina sisse anda row deco!! TODO
//       //       ///
//       //       decoration: ShapeDecorationWithPremultipliedAlpha(
//       //         color: Colors.transparent,
//       //         shape: MoonSquircleBorder(
//       //           borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
//       //           side: const BorderSide(
//       //             color: Colors.black,
//       //             width: 1,
//       //           ),
//       //         ),
//       //       ),
//       //       children: List<Widget>.filled(numberOfCols, const _NullWidget()),
//       //       // children: List<Widget>.filled(
//       //       //   numberOfCols,
//       //       //   DecoratedBox(
//       //       //     decoration: ShapeDecorationWithPremultipliedAlpha(
//       //       //       color: Colors.transparent,
//       //       //       shape: MoonSquircleBorder(
//       //       //         borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
//       //       //         borderAlign: BorderAlign.outside,
//       //       //         side: const BorderSide(
//       //       //           color: Colors.red,
//       //       //           width: 10,
//       //       //         ),
//       //       //       ),
//       //       //     ),
//       //       //   ),
//       //       // ),
//       //     ):
//       //      buildTableRowDivider(cols: numberOfCols);
//       //
//       //   }
//       // },
//     );
//
//     return tableRows;
//   }
//
//   TableRow _buildHeadingRow(
//     BuildContext context,
//     ThemeData theme,
//     MaterialStateProperty<Color?>? headingRowColor,
//     int numberOfCols,
//   ) {
//     // final bool showBorder = showBottomBorder &&
//     //     border == null &&
//     //     (dividerThickness == null || (dividerThickness != null && dividerThickness != 0.0));
//
//     ///
//     /// Propertina sisse anda header row deco!! TODO
//     ///
//     final headingRow = TableRow(
//       key: _headingRowKey,
//       decoration: ShapeDecorationWithPremultipliedAlpha(
//         color: headingRowColor?.resolve(<MaterialState>{}),
//         shape: MoonSquircleBorder(
//             // borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
//             // side: const BorderSide(color: Colors.black, width: 1),
//             ),
//       ),
//       // decoration: BoxDecoration(
//       //   // Do not add border if the border thickness is 0.
//       //   border: showBottomBorder &&
//       //           border == null &&
//       //           (dividerThickness == null || (dividerThickness != null && dividerThickness != 0.0))
//       //       ? Border(
//       //           bottom: Divider.createBorderSide(
//       //             context,
//       //             width: dividerThickness ?? theme.dataTableTheme.dividerThickness ?? _dividerThickness,
//       //           ),
//       //         )
//       //       : null,
//       //   color: headingRowColor?.resolve(<MaterialState>{}),
//       // ),
//       children: List<Widget>.filled(numberOfCols, const _NullWidget()),
//     );
//
//     return headingRow;
//   }
// }
//
// class _SortArrow extends StatefulWidget {
//   final bool visible;
//   final bool? up;
//   final Duration duration;
//   final IconData sortArrowIcon;
//
//   const _SortArrow({required this.visible, required this.up, required this.duration, required this.sortArrowIcon});
//
//   @override
//   _SortArrowState createState() => _SortArrowState();
// }
//
// class _SortArrowState extends State<_SortArrow> with TickerProviderStateMixin {
//   static const double _arrowIconBaselineOffset = -1.5;
//   static const double _arrowIconSize = 16.0;
//
//   late AnimationController _opacityController;
//   late Animation<double> _opacityAnimation;
//
//   late AnimationController _orientationController;
//   late Animation<double> _orientationAnimation;
//
//   bool? _up;
//   double _orientationOffset = 0.0;
//
//   static final Animatable<double> _turnTween =
//       Tween<double>(begin: 0.0, end: pi).chain(CurveTween(curve: Curves.easeIn));
//
//   @override
//   void initState() {
//     super.initState();
//
//     _up = widget.up;
//
//     _opacityAnimation = CurvedAnimation(
//       parent: _opacityController = AnimationController(duration: widget.duration, vsync: this),
//       curve: Curves.fastOutSlowIn,
//     )..addListener(_rebuild);
//
//     _opacityController.value = widget.visible ? 1.0 : 0.0;
//     _orientationController = AnimationController(duration: widget.duration, vsync: this);
//     _orientationAnimation = _orientationController.drive(_turnTween)
//       ..addListener(_rebuild)
//       ..addStatusListener(_resetOrientationAnimation);
//
//     if (widget.visible) _orientationOffset = widget.up! ? 0.0 : pi;
//   }
//
//   void _rebuild() {
//     setState(() {
//       // The animations changed, so we need to rebuild.
//     });
//   }
//
//   void _resetOrientationAnimation(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       assert(_orientationAnimation.value == pi);
//
//       _orientationOffset += pi;
//       _orientationController.value = 0.0;
//     }
//   }
//
//   @override
//   void didUpdateWidget(_SortArrow oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     final bool? newUp = widget.up ?? _up;
//     bool skipArrow = false;
//
//     if (oldWidget.visible != widget.visible) {
//       if (widget.visible && (_opacityController.status == AnimationStatus.dismissed)) {
//         _orientationController.stop();
//         _orientationController.value = 0.0;
//         _orientationOffset = newUp! ? 0.0 : pi;
//
//         skipArrow = true;
//       }
//
//       widget.visible ? _opacityController.forward() : _opacityController.reverse();
//     }
//
//     if ((_up != newUp) && !skipArrow) {
//       _orientationController.status == AnimationStatus.dismissed
//           ? _orientationController.forward()
//           : _orientationController.reverse();
//     }
//
//     _up = newUp;
//   }
//
//   @override
//   void dispose() {
//     _opacityController.dispose();
//     _orientationController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: _opacityAnimation.value,
//       child: Transform(
//         transform: Matrix4.rotationZ(_orientationOffset + _orientationAnimation.value)
//           ..setTranslationRaw(0.0, _arrowIconBaselineOffset, 0.0),
//         alignment: Alignment.center,
//         child: Icon(
//           widget.sortArrowIcon,
//           size: _arrowIconSize,
//         ),
//       ),
//     );
//   }
// }
//
// class _NullTableColumnWidth extends TableColumnWidth {
//   const _NullTableColumnWidth();
//
//   @override
//   double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) => throw UnimplementedError();
//
//   @override
//   double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) => throw UnimplementedError();
// }
//
// class _NullWidget extends Widget {
//   const _NullWidget();
//
//   @override
//   Element createElement() => throw UnimplementedError();
// }
//
// /// Creates pairs of scroll controllers to ensure that offset change in one scrollable is synced with the other.
// /// (e.g. table header and table body).
// class SyncedScrollControllers extends StatefulWidget {
//   const SyncedScrollControllers({
//     super.key,
//     required this.builder,
//     this.verticalController,
//     this.horizontalController,
//   });
//
//   final ScrollController? verticalController;
//   final ScrollController? horizontalController;
//
//   final Widget Function(
//     BuildContext context,
//     ScrollController coreVerticalController,
//     ScrollController coreHorizontalController,
//     ScrollController fixedVerticalController,
//     ScrollController fixedHorizontalController,
//   ) builder;
//
//   @override
//   SyncedScrollControllersState createState() => SyncedScrollControllersState();
// }
//
// class SyncedScrollControllersState extends State<SyncedScrollControllers> {
//   ScrollController? coreVerticalController;
//   ScrollController? coreHorizontalController;
//
//   late ScrollController fixedVerticalController;
//   late ScrollController fixedHorizontalController;
//
//   late LinkedScrollControllerGroup _controllersVertical;
//   late LinkedScrollControllerGroup _controllersHorizontal;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controllersVertical = LinkedScrollControllerGroup();
//     _controllersHorizontal = LinkedScrollControllerGroup();
//
//     coreVerticalController = _controllersVertical.addAndGet();
//     fixedVerticalController = _controllersVertical.addAndGet();
//     coreHorizontalController = _controllersHorizontal.addAndGet();
//     fixedHorizontalController = _controllersHorizontal.addAndGet();
//   }
//
//   @override
//   void dispose() {
//     coreVerticalController?.dispose();
//     fixedVerticalController.dispose();
//     coreHorizontalController?.dispose();
//     fixedHorizontalController.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => widget.builder(
//         context,
//         coreVerticalController!,
//         fixedVerticalController,
//         coreHorizontalController!,
//         fixedHorizontalController,
//       );
// }
