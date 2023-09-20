import 'dart:math';

import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/table/table_size_properties.dart';
import 'package:moon_design/src/theme/table/table_sizes.dart';
import 'package:moon_design/src/widgets/table/table_controllers.dart';

/// [MoonTableRow] used in [MoonTable.tableRows].
class MoonTableRow {
  /// Controls whether the row is selected or not.
  final bool selected;

  /// The height of the row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? rowHeight;

  /// Decoration of the row.
  final Decoration? rowDecoration;

  /// Callback when the row selection changes.
  final ValueChanged<bool?>? onSelectChanged;

  /// Callback when the row is tapped.
  final VoidCallback? onTap;

  /// Title widget of the row.
  final MoonTableRowTitle? rowTitle;

  /// List of table row cells.
  final List<Widget> cells;

  const MoonTableRow({
    this.selected = false,
    this.rowHeight,
    this.rowDecoration,
    this.onSelectChanged,
    this.onTap,
    this.rowTitle,
    required this.cells,
  }) : assert(cells.length > 0, 'cells length must be > 0');
}

typedef ColumnSortCallback = void Function(int columnIndex, bool ascending);

/// [MoonTableColumn] used in [MoonTableHeader.columns].
class MoonTableColumn {
  /// Controls whether the sorting icon is shown or not.
  final bool showSortingIcon;

  /// Gap between column label and sorting icon.
  final double? sortingIconGap;

  /// Defines the width of the table column.
  final double columnWidth;

  /// Icon to be displayed when sorting is applied to a column.
  /// If not set, the default icon is [MoonIcons.chevron_up_16].
  final Widget? sortingIcon;

  /// Horizontal alignment of column label and sorting icon.
  final MainAxisAlignment sortingIconAlignment;

  /// Callback when the column is sorted.
  final ColumnSortCallback? onSort;

  /// Callback when the column is tapped.
  final VoidCallback? onTap;

  /// Table column cell
  final Widget? cell;

  const MoonTableColumn({
    this.showSortingIcon = true,
    this.sortingIconGap,
    required this.columnWidth,
    this.sortingIcon,
    this.sortingIconAlignment = MainAxisAlignment.start,
    this.onSort,
    this.onTap,
    this.cell,
  });
}

/// [MoonTableHeader] used in [MoonTable.tableHeader].
class MoonTableHeader {
  /// Decoration of the table header row.
  final Decoration? decoration;

  /// The height of the table header row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? height;

  /// Margin of the table header row.
  final EdgeInsetsGeometry? margin;

  /// List of table header columns.
  final List<MoonTableColumn> columns;

  const MoonTableHeader({
    this.decoration,
    this.height,
    this.margin,
    required this.columns,
  }) : assert(columns.length > 0, 'columns length must be > 0');
}

/// [MoonTableFooter] used in [MoonTable.tableFooter].
class MoonTableFooter {
  /// Decoration of the table footer row.
  final Decoration? decoration;

  /// The height of the table footer row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? height;

  /// Margin of the table footer row.
  final EdgeInsetsGeometry? margin;

  /// List of table footer cells.
  final List<Widget> cells;

  const MoonTableFooter({
    this.decoration,
    this.height,
    this.margin,
    required this.cells,
  }) : assert(cells.length > 0, 'if footer is provided, cells length must be > 0');
}

/// [MoonTableRowTitle] used in [MoonTableRow.rowTitle].
class MoonTableRowTitle {
  /// Controls whether title of the row is sticky or not during horizontal scroll.
  final bool isSticky;

  /// Row animated title transition duration.
  final Duration? transitionDuration;

  /// Row animated title transition curve.
  final Curve? transitionCurve;

  /// Text style of the row title.
  final TextStyle? textStyle;

  /// Animated text style of the row title when [isSticky] is true.
  final TextStyle? animatedTextStyle;

  /// Row title widget.
  final Widget title;

  const MoonTableRowTitle({
    this.isSticky = true,
    this.transitionDuration,
    this.transitionCurve,
    this.textStyle,
    this.animatedTextStyle,
    required this.title,
  });
}

enum MoonTableRowSize {
  xs,
  sm,
  md,
  lg,
  xl,
  x2l,
}

typedef OnScrollControllersReady = void Function(
  ScrollController verticalController,
  ScrollController horizontalController,
);

class MoonTable extends StatefulWidget {
  /// Controls whether the header of the table is fixed or scrollable with table body.
  final bool hasFixedHeader;

  /// Controls whether the footer of the table is fixed or scrollable with table body.
  final bool hasFixedFooter;

  /// Controls if the empty rows placeholder is scrollable or not.
  final bool hasFixedRowsPlaceHolder;

  /// Controls if the pagination placeholder is scrollable or not.
  final bool hasFixedPaginationPlaceHolder;

  /// Controls whether the column of the table should be sorted ascending or descending.
  final bool sortAscending;

  /// The index of the column to be sorted by.
  final int sortColumnIndex;

  /// Decoration for the table.
  final Decoration? tableDecoration;

  /// Gap between table rows.
  final double? rowGap;

  /// The whole table height. Defaults to null using up all available space.
  final double? height;

  /// Margin of the table rows.
  final EdgeInsetsGeometry? rowMargin;

  /// Padding of the table row cells.
  final EdgeInsetsGeometry? cellPadding;

  /// The size of the table row, applied to [MoonTableHeader], [MoonTableFooter] and [MoonTableRow],
  /// unless these classes have their own height specified.
  /// If [MoonTable.rowSize] is unspecified, the height will dynamically adjust based on the row's content.
  final MoonTableRowSize? rowSize;

  /// Returning the vertical and horizontal controller for external usage.
  final OnScrollControllersReady? onScrollControllersReady;

  /// Vertical scroll physics of the table.
  final ScrollPhysics? verticalScrollPhysics;

  /// Horizontal scroll physics of the table.
  final ScrollPhysics? horizontalScrollPhysics;

  /// Table header for [MoonTable] widget.
  final MoonTableHeader tableHeader;

  /// Table footer for [MoonTable] widget.
  final MoonTableFooter? tableFooter;

  /// List of [MoonTable] row items.
  final List<MoonTableRow> tableRows;

  /// Placeholder for table pagination. By default it is not scrollable.
  /// To make it scrollable, set [hasFixedPaginationPlaceHolder] to false.
  /// PlaceHolder is placed above the [MoonTableFooter] if it is provided.
  final Widget? paginationPlaceHolder;

  /// Widget to show when list of [tableRows] is empty. By default it is not scrollable.
  /// To make it scrollable, set [hasFixedRowsPlaceHolder] to false.
  final Widget? rowsPlaceHolder;

  /// Row divider widget. Applies to all table body rows.
  final Widget? rowSeparatorWidget;

  final int? width;

  const MoonTable({
    super.key,
    this.width,
    this.hasFixedHeader = true,
    this.hasFixedFooter = true,
    this.hasFixedPaginationPlaceHolder = true,
    this.hasFixedRowsPlaceHolder = true,
    this.sortAscending = false,
    this.sortColumnIndex = 0,
    this.tableDecoration,
    this.rowGap,
    this.height,
    this.rowMargin,
    this.cellPadding,
    this.rowSize,
    this.onScrollControllersReady,
    this.verticalScrollPhysics,
    this.horizontalScrollPhysics,
    required this.tableHeader,
    this.tableFooter,
    required this.tableRows,
    this.rowsPlaceHolder,
    this.paginationPlaceHolder,
    this.rowSeparatorWidget,
  })  : assert(height == null || height > 0, 'tableHeight can only be null or > 0'),
        assert(sortColumnIndex >= 0, 'sortColumnIndex can only be >= 0');

  @override
  State<StatefulWidget> createState() => _MoonTableState();
}

class _MoonTableState extends State<MoonTable> {
  late TableControllers _tableControllers;
  late MoonTableSizeProperties _effectiveMoonTableRowSize;
  late double _tableWidth;
  late EdgeInsets _cellPadding;

  double getTableWidthFromHeaderCells() {
    double tableWidth = 0.0;

    // if (widget.width != null) return widget.width;

    for (int i = 0; i < widget.tableHeader.columns.length; i++) {
      tableWidth += widget.tableHeader.columns[i].columnWidth;
    }

    final double tableHorizontalPadding = widget.rowMargin?.horizontal ?? 0.0;
    final double tableHeaderHorizontalPadding = widget.tableHeader.margin?.horizontal ?? 0.0;
    final double tableFooterHorizontalPadding = widget.tableFooter?.margin?.horizontal ?? 0.0;

    final double maxHorizontalPadding =
        max(tableHorizontalPadding, max(tableHeaderHorizontalPadding, tableFooterHorizontalPadding));

    return tableWidth + maxHorizontalPadding;
  }

  MoonTableSizeProperties _getMoonTableRowSize(BuildContext context, MoonTableRowSize? moonTableRowSize) {
    switch (moonTableRowSize) {
      case MoonTableRowSize.xs:
        return context.moonTheme?.tableTheme.sizes.xs ?? MoonTableSizes(tokens: MoonTokens.light).xs;
      case MoonTableRowSize.sm:
        return context.moonTheme?.tableTheme.sizes.sm ?? MoonTableSizes(tokens: MoonTokens.light).sm;
      case MoonTableRowSize.md:
        return context.moonTheme?.tableTheme.sizes.md ?? MoonTableSizes(tokens: MoonTokens.light).md;
      case MoonTableRowSize.lg:
        return context.moonTheme?.tableTheme.sizes.lg ?? MoonTableSizes(tokens: MoonTokens.light).lg;
      case MoonTableRowSize.xl:
        return context.moonTheme?.tableTheme.sizes.xl ?? MoonTableSizes(tokens: MoonTokens.light).xl;
      case MoonTableRowSize.x2l:
        return context.moonTheme?.tableTheme.sizes.x2l ?? MoonTableSizes(tokens: MoonTokens.light).x2l;
      default:
        return context.moonTheme?.tableTheme.sizes.md ?? MoonTableSizes(tokens: MoonTokens.light).md;
    }
  }

  @override
  void initState() {
    super.initState();

    assert(widget.tableHeader.columns.isNotEmpty, 'table header columns must not be empty');
    assert(
      widget.tableFooter == null ||
          widget.tableFooter != null && widget.tableHeader.columns.length == widget.tableFooter!.cells.length,
      'if tableFooter is not null, tableFooter.columns.length must be equal to tableHeader.columns.length',
    );

    _tableControllers = TableControllers(
      hasFixedHeader: widget.hasFixedHeader,
      hasFixedFooter: widget.hasFixedFooter,
      hasFixedRowsPlaceholder: widget.hasFixedRowsPlaceHolder,
      hasFixedPaginationPlaceholder: widget.hasFixedPaginationPlaceHolder,
    );

    _tableControllers.init();

    widget.onScrollControllersReady?.call(
      _tableControllers.verticalScrollController,
      _tableControllers.horizontalScrollController,
    );
  }

  @override
  void dispose() {
    _tableControllers.dispose();

    super.dispose();
  }

  Widget _buildHeader() {
    final Color effectiveTextColor =
        context.moonTheme?.tableTheme.colors.columnTextColor ?? MoonColors.light.textPrimary;

    final double? effectiveHeaderHeight =
        widget.tableHeader.height ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

    final double effectiveSortIconSize = _effectiveMoonTableRowSize.sortIconSizeValue;

    final EdgeInsets? resolvedRowPadding = widget.tableHeader.margin?.resolve(Directionality.of(context));

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.columnTextStyle.copyWith(color: effectiveTextColor);

    return Container(
      height: effectiveHeaderHeight,
      width: _tableWidth,
      decoration: widget.tableHeader.decoration,
      margin: resolvedRowPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.tableHeader.columns.length,
          (int index) {
            final MoonTableColumn currentColumn = widget.tableHeader.columns[index];
            final bool showSortingIcon = currentColumn.onSort != null && currentColumn.showSortingIcon;

            final double effectiveSortingIconGap =
                currentColumn.sortingIconGap ?? _effectiveMoonTableRowSize.sortIconGap;

            final Widget effectiveSortingIcon =
                currentColumn.sortingIcon ?? MoonIcon(MoonIcons.chevron_up_16, size: effectiveSortIconSize);

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => {
                currentColumn.onTap?.call(),
                currentColumn.onSort?.call(index, !widget.sortAscending),
              },
              child: SizedBox(
                width: currentColumn.columnWidth,
                child: Padding(
                  padding: _cellPadding,
                  child: DefaultTextStyle(
                    style: effectiveTextStyle,
                    child: showSortingIcon && index == widget.sortColumnIndex
                        ? Row(
                            mainAxisAlignment: currentColumn.sortingIconAlignment,
                            children: [
                              currentColumn.cell ?? const SizedBox(),
                              _SortIcon(
                                gap: effectiveSortingIconGap,
                                icon: effectiveSortingIcon,
                                iconSize: effectiveSortIconSize,
                                visible: index == widget.sortColumnIndex,
                                up: index == widget.sortColumnIndex ? widget.sortAscending : null,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: currentColumn.cell ?? const SizedBox(),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFooter() {
    final Color effectiveTextColor =
        context.moonTheme?.tableTheme.colors.columnTextColor ?? MoonColors.light.textPrimary;

    final double? effectiveFooterHeight =
        widget.tableFooter?.height ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

    final EdgeInsets? resolvedFooterPadding = widget.tableFooter?.margin?.resolve(Directionality.of(context));

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.columnTextStyle.copyWith(color: effectiveTextColor);

    return Container(
      height: effectiveFooterHeight,
      width: _tableWidth,
      decoration: widget.tableFooter!.decoration,
      margin: resolvedFooterPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.tableFooter!.cells.length,
          (int index) {
            return SizedBox(
              width: widget.tableHeader.columns[index].columnWidth,
              child: DefaultTextStyle(
                style: effectiveTextStyle,
                child: Padding(
                  padding: _cellPadding,
                  child: widget.tableFooter!.cells[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRows() {
    final bool hasScrollableHeader = !widget.hasFixedHeader;
    final bool hasScrollableFooter = !widget.hasFixedFooter && widget.tableFooter != null;

    final BorderRadiusGeometry effectiveRowBorderRadius = _effectiveMoonTableRowSize.rowBorderRadius;

    final Color effectiveTextColor = context.moonTheme?.tableTheme.colors.rowTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveRowBackgroundColor =
        context.moonTheme?.tableTheme.colors.rowBackgroundColor ?? MoonColors.light.gohan;

    final double effectiveRowGap = widget.rowGap ?? _effectiveMoonTableRowSize.rowGap;

    final EdgeInsets effectiveCellPadding =
        (widget.cellPadding ?? _effectiveMoonTableRowSize.cellPadding).resolve(Directionality.of(context));

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.rowTextStyle.copyWith(color: effectiveTextColor);

    return CustomScrollView(
      controller: _tableControllers.verticalScrollController,
      physics: widget.verticalScrollPhysics,
      slivers: <Widget>[
        if (hasScrollableHeader)
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
        if (widget.tableRows.isNotEmpty)
          SliverPadding(
            padding: widget.rowMargin ?? EdgeInsets.zero,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  assert(
                    widget.tableRows[index].cells.length == widget.tableHeader.columns.length,
                    'table row cells count must be equal to header columns count',
                  );

                  final MoonTableRow currentRow = widget.tableRows[index];
                  final bool isLastRow = index == widget.tableRows.length - 1;
                  final bool isFirstRow = index == 0;

                  final double? effectiveRowHeight =
                      currentRow.rowHeight ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

                  final TextStyle effectiveTitleTextStyle =
                      _effectiveMoonTableRowSize.rowTitleTextStyle.merge(currentRow.rowTitle?.textStyle);

                  final TextStyle effectiveAnimatedTitleTextStyle = _effectiveMoonTableRowSize.rowAnimatedTitleTextStyle
                      .merge(currentRow.rowTitle?.animatedTextStyle);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          currentRow.onSelectChanged?.call(!currentRow.selected),
                          currentRow.onTap?.call(),
                        },
                        child: Container(
                          height: effectiveRowHeight,
                          margin: EdgeInsets.only(
                            top: isFirstRow ? 0 : effectiveRowGap / 2,
                            bottom: isLastRow ? 0 : effectiveRowGap / 2,
                          ),
                          decoration: currentRow.rowDecoration ??
                              ShapeDecorationWithPremultipliedAlpha(
                                color: effectiveRowBackgroundColor,
                                shape: MoonSquircleBorder(
                                  borderRadius: effectiveRowBorderRadius.squircleBorderRadius(context),
                                ),
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentRow.rowTitle != null)
                                Padding(
                                  padding: effectiveCellPadding,
                                  child: _TableRowTitle(
                                    rowTitle: currentRow.rowTitle!,
                                    titleTextStyle: effectiveTitleTextStyle,
                                    animatedTitleTextStyle: effectiveAnimatedTitleTextStyle,
                                    horizontalScrollController: _tableControllers.horizontalScrollController,
                                  ),
                                ),
                              Row(
                                children: [
                                  for (var i = 0; i < currentRow.cells.length; i++)
                                    SizedBox(
                                      width: widget.tableHeader.columns[i].columnWidth,
                                      height: currentRow.rowTitle != null ? null : effectiveRowHeight,
                                      child: DefaultTextStyle(
                                        style: effectiveTextStyle,
                                        child: Padding(
                                          padding: effectiveCellPadding,
                                          child: Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: currentRow.cells[i],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.rowSeparatorWidget != null && !isLastRow) widget.rowSeparatorWidget!,
                    ],
                  );
                },
                childCount: widget.tableRows.length,
              ),
            ),
          ),
        if (hasScrollableFooter)
          SliverToBoxAdapter(
            child: _buildFooter(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _effectiveMoonTableRowSize = _getMoonTableRowSize(context, widget.rowSize);

    _cellPadding = (widget.cellPadding ?? _effectiveMoonTableRowSize.cellPadding).resolve(Directionality.of(context));

    _tableWidth = getTableWidthFromHeaderCells();

    final Color effectiveIconColor = context.moonTheme?.tableTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    return SizedBox(
      height: widget.height,
      child: IconTheme(
        data: IconThemeData(color: effectiveIconColor),
        child: Column(
          children: [
            if (widget.hasFixedHeader)
              SingleChildScrollView(
                physics: widget.horizontalScrollPhysics,
                controller: _tableControllers.headerHorizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: _buildHeader(),
              ),
            if (widget.tableRows.isEmpty && widget.rowsPlaceHolder != null)
              widget.hasFixedRowsPlaceHolder
                  ? widget.rowsPlaceHolder!
                  : SingleChildScrollView(
                      physics: widget.horizontalScrollPhysics,
                      controller: _tableControllers.rowsPlaceholderScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: _tableWidth,
                        child: widget.rowsPlaceHolder,
                      ),
                    ),
            Expanded(
              child: SingleChildScrollView(
                physics: widget.horizontalScrollPhysics,
                controller: _tableControllers.horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: _tableWidth,
                  child: _buildRows(),
                ),
              ),
            ),
            if (widget.paginationPlaceHolder != null)
              widget.hasFixedPaginationPlaceHolder
                  ? widget.paginationPlaceHolder!
                  : SingleChildScrollView(
                      physics: widget.horizontalScrollPhysics,
                      controller: _tableControllers.paginationPlaceHolderScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: _tableWidth,
                        child: widget.paginationPlaceHolder,
                      ),
                    ),
            if (widget.hasFixedFooter && widget.tableFooter != null)
              SingleChildScrollView(
                physics: widget.horizontalScrollPhysics,
                controller: _tableControllers.footerHorizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: _buildFooter(),
              ),
          ],
        ),
      ),
    );
  }
}

class _TableRowTitle extends StatelessWidget {
  final MoonTableRowTitle rowTitle;
  final TextStyle titleTextStyle;
  final TextStyle animatedTitleTextStyle;
  final ScrollController horizontalScrollController;

  const _TableRowTitle({
    required this.rowTitle,
    required this.titleTextStyle,
    required this.animatedTitleTextStyle,
    required this.horizontalScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveTitleTextColor =
        titleTextStyle.color ?? context.moonTheme?.tableTheme.colors.rowTitleTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveAnimatedTitleTextColor = animatedTitleTextStyle.color ??
        context.moonTheme?.tableTheme.colors.rowAnimatedTitleTextColor ??
        MoonColors.light.trunks;

    final Duration effectiveTransitionDuration = rowTitle.transitionDuration ??
        context.moonTheme?.tableTheme.properties.transitionDuration ??
        const Duration(milliseconds: 400);

    final Curve effectiveTransitionCurve =
        rowTitle.transitionCurve ?? context.moonTheme?.tableTheme.properties.transitionCurve ?? Curves.easeInOutCubic;

    final TextStyle resolvedTitleTextStyle = titleTextStyle.copyWith(color: effectiveTitleTextColor);

    final TextStyle resolvedAnimatedTitleTextStyle =
        animatedTitleTextStyle.copyWith(color: effectiveAnimatedTitleTextColor);

    return rowTitle.isSticky
        ? AnimatedBuilder(
            animation: horizontalScrollController,
            builder: (BuildContext context, Widget? child) {
              double widgetOffset = 0;
              double scrollOffset = horizontalScrollController.offset;

              final bool offsetIsIncreasing = (scrollOffset - widgetOffset) > 0;

              if (scrollOffset < 0) scrollOffset = 0;
              if (widgetOffset != scrollOffset) widgetOffset = scrollOffset;

              return Padding(
                padding: EdgeInsetsDirectional.only(start: widgetOffset),
                child: AnimatedDefaultTextStyle(
                  style: offsetIsIncreasing ? resolvedAnimatedTitleTextStyle : resolvedTitleTextStyle,
                  curve: effectiveTransitionCurve,
                  duration: effectiveTransitionDuration,
                  child: child!,
                ),
              );
            },
            child: rowTitle.title,
          )
        : rowTitle.title;
  }
}

class _SortIcon extends StatefulWidget {
  final bool visible;
  final bool? up;
  final double gap;
  final double iconSize;
  final Widget icon;

  const _SortIcon({
    required this.visible,
    required this.up,
    required this.gap,
    required this.iconSize,
    required this.icon,
  });

  @override
  _SortIconState createState() => _SortIconState();
}

class _SortIconState extends State<_SortIcon> with TickerProviderStateMixin {
  final Animatable<double> _turnTween = Tween<double>(begin: 0.0, end: pi).chain(CurveTween(curve: Curves.easeIn));

  final Duration _animationDuration = const Duration(milliseconds: 200);

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
      parent: _opacityController = AnimationController(duration: _animationDuration, vsync: this),
      curve: Curves.fastOutSlowIn,
    )..addListener(_rebuild);
    _opacityController.value = widget.visible ? 1.0 : 0.0;

    _orientationController = AnimationController(duration: _animationDuration, vsync: this);
    _orientationAnimation = _orientationController.drive(_turnTween)
      ..addListener(_rebuild)
      ..addStatusListener(_resetOrientationAnimation);

    if (widget.visible) _orientationOffset = widget.up! ? 0.0 : pi;
  }

  void _rebuild() {
    setState(() {
      // The animation changed, so we need to rebuild.
    });
  }

  void _resetOrientationAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      assert(_orientationAnimation.value == pi);

      _orientationOffset += pi;
      _orientationController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(_SortIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool? newUp = widget.up ?? _up;
    bool skipIcon = false;

    if (oldWidget.visible != widget.visible) {
      if (widget.visible && (_opacityController.status == AnimationStatus.dismissed)) {
        _orientationController.stop();
        _orientationController.value = 0.0;
        _orientationOffset = newUp! ? 0.0 : pi;
        skipIcon = true;
      }

      widget.visible ? _opacityController.forward() : _opacityController.reverse();
    }

    if (_up != newUp && !skipIcon) {
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
    return Padding(
      padding: EdgeInsetsDirectional.only(start: widget.gap),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Transform(
          transform: Matrix4.rotationZ(_orientationOffset + _orientationAnimation.value),
          alignment: Alignment.center,
          child: widget.icon,
        ),
      ),
    );
  }
}
