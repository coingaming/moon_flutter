import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';
import 'package:moon_design/src/theme/table/table_size_properties.dart';
import 'package:moon_design/src/theme/table/table_sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/widgets/common/default_animated_text_style.dart';
import 'package:moon_design/src/widgets/table/table_controllers.dart';

/// [MoonTableRow] used in [MoonTable.rows].
class MoonTableRow {
  /// Controls whether the row is selected or not.
  final bool selected;

  /// The height of the row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? height;

  /// Decoration of the row.
  final Decoration? decoration;

  /// Callback when the row selection changes.
  final ValueChanged<bool?>? onSelectChanged;

  /// Callback when the row is tapped.
  final VoidCallback? onTap;

  /// Label of the row which expands to the whole width of the row. Placed on top of the row cells.
  final MoonTableRowLabel? label;

  /// List of table row cells.
  /// The length of the list must be equal to the length of [MoonTableHeader.columns] and can not be empty.
  final List<Widget> cells;

  const MoonTableRow({
    this.selected = false,
    this.height,
    this.decoration,
    this.onSelectChanged,
    this.onTap,
    this.label,
    required this.cells,
  }) : assert(cells.length > 0, 'Cells length must not be empty.');
}

typedef ColumnSortCallback = void Function(int columnIndex, bool ascending);

/// [MoonTableColumn] used in [MoonTableHeader.columns].
class MoonTableColumn {
  /// Controls whether the sorting icon is shown or not.
  final bool showSortingIcon;

  /// Gap between column label and sorting icon.
  final double? sortingIconGap;

  /// Defines the width of the table column.
  /// Either [width] for each column or [MoonTable.width] must be provided.
  /// This is exclusive with [MoonTable.width]. Both can not be used at the same time.
  final double? width;

  /// Horizontal alignment of column label and sorting icon.
  final MainAxisAlignment sortingIconAlignment;

  /// Callback when the column is sorted.
  final ColumnSortCallback? onSort;

  /// Callback when the column is tapped.
  final VoidCallback? onTap;

  /// Table column cell.
  final Widget? cell;

  /// Icon to be displayed when sorting is applied to a column.
  /// If not set, the default icon is [MoonIcons.chevron_up_16].
  /// Shown only if [showSortingIcon] is true and [onSort] is not null.
  final Widget? sortingIcon;

  const MoonTableColumn({
    this.showSortingIcon = true,
    this.sortingIconGap,
    this.width,
    this.sortingIconAlignment = MainAxisAlignment.start,
    this.onSort,
    this.onTap,
    this.cell,
    this.sortingIcon,
  });
}

/// [MoonTableHeader] used in [MoonTable.header].
class MoonTableHeader {
  /// Decoration of the table header row.
  final Decoration? decoration;

  /// The height of the table header row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? height;

  /// List of table header columns.
  final List<MoonTableColumn> columns;

  const MoonTableHeader({
    this.decoration,
    this.height,
    required this.columns,
  }) : assert(columns.length > 0, 'If header is provided, columns must not be empty.');
}

/// [MoonTableFooter] used in [MoonTable.footer].
class MoonTableFooter {
  /// Decoration of the table footer row.
  final Decoration? decoration;

  /// The height of the table footer row, primarily determined by this value. If not specified,
  /// [MoonTable.rowSize] is used. If [MoonTable.rowSize] is also unspecified,
  /// the height will dynamically adjust based on the row's content.
  final double? height;

  /// List of table footer cells. Cells length must be equal to [MoonTableHeader.columns] length.
  /// If footer is provided, [cells] must not be empty.
  final List<Widget> cells;

  const MoonTableFooter({
    this.decoration,
    this.height,
    required this.cells,
  }) : assert(cells.length > 0, 'If footer is provided, cells must not be empty.');
}

/// [MoonTableRowLabel] used in [MoonTableRow.label].
class MoonTableRowLabel {
  /// Controls whether label of the row is pinned or not during table horizontal scroll.
  final bool pinned;

  /// Row's animated label transition duration during horizontal scroll.
  final Duration? transitionDuration;

  /// Row's animated label transition curve during horizontal scroll.
  final Curve? transitionCurve;

  /// Label padding.
  final EdgeInsetsGeometry? padding;

  /// Text style of the row's label when [pinned] is true and the table is being horizontally scrolled.
  final TextStyle? textStyle;

  /// Animated text style of row's label when [pinned] is true and the table is being horizontally scrolled.
  final TextStyle? pinnedAnimatedTextStyle;

  /// Row label widget. Placed on top of the row cells.
  final Widget label;

  const MoonTableRowLabel({
    this.pinned = true,
    this.transitionDuration,
    this.transitionCurve,
    this.padding,
    this.textStyle,
    this.pinnedAnimatedTextStyle,
    required this.label,
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
  /// Controls whether the header of the table is pinned or vertically scrollable with table body.
  final bool isHeaderPinned;

  /// Controls whether the footer of the table is pinned or vertically scrollable with table body.
  final bool isFooterPinned;

  /// Controls if the empty rows placeholder is pinned or horizontally scrollable with table body.
  final bool isRowsPlaceholderPinned;

  /// Controls whether the column of the table should be sorted in ascending or descending order.
  final bool sortAscending;

  /// Decoration of the table.
  final Decoration? decoration;

  /// Gap between table rows.
  final double? rowGap;

  /// The whole height of the table. Defaults to null using up all available space.
  final double? height;

  /// The width of the table.
  /// Either [MoonTable.width] or [MoonTableColumn.width] for each column must be provided.
  /// This is exclusive with [MoonTableColumn.width]. Both can not be used at the same time.
  final double? width;

  /// Padding of the table row cells.
  final EdgeInsetsGeometry? cellPadding;

  /// Padding of the table.
  final EdgeInsetsGeometry? tablePadding;

  /// The index of the column to be sorted by.
  final int sortColumnIndex;

  /// Specifies how many columns is in the table.
  final int columnsCount;

  /// The size of the table row, applied to [MoonTableHeader], [MoonTableFooter] and [MoonTableRow],
  /// unless these classes have their own height specified.
  /// If [MoonTable.rowSize] is unspecified, the height will dynamically adjust based on the row's content.
  final MoonTableRowSize? rowSize;

  /// Scroll behavior for [MoonTable].
  final ScrollBehavior? scrollBehaviour;

  /// Vertical scroll physics of the table.
  final ScrollPhysics? verticalScrollPhysics;

  /// Horizontal scroll physics of the table.
  final ScrollPhysics? horizontalScrollPhysics;

  /// The semantic label for the table.
  final String? semanticLabel;

  /// Returning the vertical and horizontal controller for external usage.
  final OnScrollControllersReady? onScrollControllersReady;

  /// Table header for [MoonTable] widget.
  final MoonTableHeader? header;

  /// Table footer for [MoonTable] widget.
  final MoonTableFooter? footer;

  /// List of [MoonTable] rows.
  final List<MoonTableRow> rows;

  /// Widget to show only when provided list of [rows] is empty.
  /// By default not horizontally scrollable. To make it scrollable, set [pinnedRowsPlaceHolder] to false.
  final Widget? rowsPlaceholder;

  /// Divider widget between all table body rows.
  final Widget? rowDivider;

  /// Widget that is shown at the end of a vertical rows list to signify ongoing content loading while scrolling down.
  final Widget? loadingIndicator;

  const MoonTable({
    super.key,
    this.width,
    this.isHeaderPinned = true,
    this.isFooterPinned = true,
    this.isRowsPlaceholderPinned = true,
    this.sortAscending = false,
    this.sortColumnIndex = 0,
    required this.columnsCount,
    this.decoration,
    this.rowGap,
    this.height,
    this.cellPadding,
    this.tablePadding,
    this.rowSize,
    this.scrollBehaviour,
    this.verticalScrollPhysics,
    this.horizontalScrollPhysics,
    this.semanticLabel,
    this.onScrollControllersReady,
    this.header,
    this.footer,
    required this.rows,
    this.rowsPlaceholder,
    this.rowDivider,
    this.loadingIndicator,
  })  : assert(height == null || height > 0, 'Table height can only be null or > 0.'),
        assert(sortColumnIndex >= 0, 'SortColumnIndex can only be >= 0.'),
        assert(columnsCount > 0, 'Columns count must be > 0');

  @override
  State<StatefulWidget> createState() => _MoonTableState();
}

class _MoonTableState extends State<MoonTable> {
  late TableControllers _tableControllers;
  late MoonTableSizeProperties _effectiveMoonTableRowSize;
  late double _tableWidth;
  late EdgeInsetsGeometry _effectiveCellPadding;

  double _columnEqualWidth = 0;

  void _assertRequirements() {
    final bool hasTableFooter = widget.footer != null;
    final bool hasTableHeader = widget.header != null;

    assert(
      !hasTableFooter || hasTableFooter && widget.footer!.cells.length == widget.columnsCount,
      'If footer is not null, footer.cells.length must be equal to widget.columnsCount.',
    );

    assert(
      !hasTableHeader || hasTableHeader && widget.header!.columns.length == widget.columnsCount,
      'If header is not null, header.columns.length must be equal to widget.columnsCount.',
    );

    if (widget.header != null) {
      for (final column in widget.header!.columns) {
        if (widget.width == null) {
          assert(
            column.width != null,
            'If table width is null, each provided header column must have a width specified.',
          );
        } else {
          assert(column.width == null, 'If table width is not null, each provided column width must be null.');
        }
      }
    } else {
      assert(widget.width != null, 'If table header is null, table width must be specified.');
    }
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

  void _calculateTableWidth() {
    // If a table width is specified, the available space is divided equally among the columns.
    if (widget.width != null) {
      _columnEqualWidth = widget.width! / widget.columnsCount;

      _tableWidth = widget.width!;
    } else {
      // Calculate table width based on columns widths.
      _tableWidth = widget.header!.columns.fold<double>(
        0,
        (double totalWidth, MoonTableColumn column) => totalWidth + (column.width!),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _assertRequirements();

    _tableControllers = TableControllers(
      isHeaderPinned: widget.isHeaderPinned,
      isFooterPinned: widget.isFooterPinned,
      hasPinnedEmptyPlaceholder: widget.isRowsPlaceholderPinned,
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
    assert(widget.header != null);

    final MoonTableHeader header = widget.header!;

    final Color effectiveTextColor =
        context.moonTheme?.tableTheme.colors.columnTextColor ?? MoonColors.light.textPrimary;

    final double? effectiveHeight =
        header.height ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

    final double effectiveSortIconSize = _effectiveMoonTableRowSize.sortIconSizeValue;

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.columnTextStyle.copyWith(color: effectiveTextColor);

    return Container(
      height: effectiveHeight,
      width: _tableWidth,
      decoration: header.decoration,
      child: Row(
        children: List.generate(
          header.columns.length,
          (int index) {
            final MoonTableColumn currentColumn = header.columns[index];
            final bool showSortingIcon = currentColumn.onSort != null && currentColumn.showSortingIcon;

            final double effectiveColumnWidth = currentColumn.width ?? _columnEqualWidth;

            final double effectiveSortingIconGap =
                currentColumn.sortingIconGap ?? _effectiveMoonTableRowSize.sortIconGap;

            final Widget effectiveSortingIcon =
                currentColumn.sortingIcon ?? Icon(MoonIcons.controls_chevron_up_16_light, size: effectiveSortIconSize);

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                currentColumn.onTap?.call();
                currentColumn.onSort?.call(index, !widget.sortAscending);
              },
              child: SizedBox(
                width: effectiveColumnWidth,
                child: Padding(
                  padding: _effectiveCellPadding,
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
                        : Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: currentColumn.cell ?? const SizedBox(),
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
        widget.footer?.height ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.columnTextStyle.copyWith(color: effectiveTextColor);

    return Container(
      height: effectiveFooterHeight,
      width: _tableWidth,
      decoration: widget.footer!.decoration,
      child: Row(
        children: List.generate(
          widget.footer!.cells.length,
          (int index) {
            final double effectiveColumnWidth = widget.header?.columns[index].width ?? _columnEqualWidth;

            return SizedBox(
              width: effectiveColumnWidth,
              child: DefaultTextStyle(
                style: effectiveTextStyle,
                child: Padding(
                  padding: _effectiveCellPadding,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: widget.footer!.cells[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRows() {
    final bool hasScrollableHeader = !widget.isHeaderPinned;
    final bool hasScrollableFooter = !widget.isFooterPinned && widget.footer != null;

    final BorderRadiusGeometry effectiveBorderRadius = _effectiveMoonTableRowSize.rowBorderRadius;

    final Color effectiveTextColor = context.moonTheme?.tableTheme.colors.rowTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveBackgroundColor =
        context.moonTheme?.tableTheme.colors.rowBackgroundColor ?? MoonColors.light.gohan;

    final double effectiveGap = widget.rowGap ?? _effectiveMoonTableRowSize.rowGap;

    final TextStyle effectiveTextStyle = _effectiveMoonTableRowSize.rowTextStyle.copyWith(color: effectiveTextColor);

    return CustomScrollView(
      controller: _tableControllers.verticalScrollController,
      physics: widget.verticalScrollPhysics,
      slivers: <Widget>[
        if (hasScrollableHeader && widget.header != null)
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
        if (widget.rows.isNotEmpty)
          SliverList.separated(
            itemCount: widget.rows.length + 1,
            separatorBuilder: (BuildContext context, int index) => widget.rowDivider ?? const SizedBox(),
            itemBuilder: (BuildContext context, int index) {
              if (index < widget.rows.length) {
                final MoonTableRow currentRow = widget.rows[index];
                final bool firstRow = index == 0;
                final bool lastRow = index == widget.rows.length - 1;

                assert(
                  currentRow.cells.length == widget.columnsCount,
                  'Table row cells count must be equal to table columns count.',
                );

                final double? effectiveRowHeight =
                    currentRow.height ?? (widget.rowSize == null ? null : _effectiveMoonTableRowSize.rowHeight);

                final EdgeInsetsGeometry effectiveLabelPadding =
                    currentRow.label?.padding ?? _effectiveMoonTableRowSize.rowLabelPadding;

                final TextStyle effectiveLabelTextStyle =
                    _effectiveMoonTableRowSize.rowLabelTextStyle.merge(currentRow.label?.textStyle);

                final TextStyle effectiveAnimatedLabelTextStyle = _effectiveMoonTableRowSize
                    .rowPinnedAnimatedLabelTextStyle
                    .merge(currentRow.label?.pinnedAnimatedTextStyle);

                return GestureDetector(
                  onTap: () {
                    currentRow.onSelectChanged?.call(!currentRow.selected);
                    currentRow.onTap?.call();
                  },
                  child: Container(
                    height: effectiveRowHeight,
                    margin: EdgeInsets.only(
                      top: firstRow ? 0 : effectiveGap / 2,
                      bottom: lastRow ? 0 : effectiveGap / 2,
                    ),
                    decoration: currentRow.decoration ??
                        ShapeDecorationWithPremultipliedAlpha(
                          color: effectiveBackgroundColor,
                          shape: MoonSquircleBorder(
                            borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                          ),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (currentRow.label != null)
                          Padding(
                            padding: effectiveLabelPadding,
                            child: _TableRowLabel(
                              label: currentRow.label!,
                              labelTextStyle: effectiveLabelTextStyle,
                              animatedLabelTextStyle: effectiveAnimatedLabelTextStyle,
                              horizontalScrollController: _tableControllers.horizontalScrollController,
                            ),
                          ),
                        Row(
                          children: [
                            for (var i = 0; i < currentRow.cells.length; i++)
                              SizedBox(
                                width: widget.header?.columns[i].width ?? _columnEqualWidth,
                                height: currentRow.label != null ? null : effectiveRowHeight,
                                child: DefaultTextStyle(
                                  style: effectiveTextStyle,
                                  child: Padding(
                                    padding: _effectiveCellPadding,
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
                );
              } else {
                return widget.loadingIndicator ?? const SizedBox();
              }
            },
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
    _calculateTableWidth();

    _effectiveMoonTableRowSize = _getMoonTableRowSize(context, widget.rowSize);

    _effectiveCellPadding = widget.cellPadding ?? _effectiveMoonTableRowSize.cellPadding;

    final Color effectiveIconColor = context.moonTheme?.tableTheme.colors.iconColor ?? MoonColors.light.iconPrimary;

    final ScrollBehavior effectiveScrollBehavior = widget.scrollBehaviour ??
        ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        );

    return Semantics(
      label: widget.semanticLabel,
      child: Container(
        width: _tableWidth,
        height: widget.height,
        decoration: widget.decoration,
        padding: widget.tablePadding,
        clipBehavior: widget.decoration == null ? Clip.none : Clip.hardEdge,
        child: IconTheme(
          data: IconThemeData(color: effectiveIconColor),
          child: ScrollConfiguration(
            behavior: effectiveScrollBehavior,
            child: Column(
              children: [
                if (widget.isHeaderPinned && widget.header != null)
                  SingleChildScrollView(
                    physics: widget.horizontalScrollPhysics,
                    controller: _tableControllers.headerHorizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: _buildHeader(),
                  ),
                if (widget.rows.isEmpty && widget.rowsPlaceholder != null)
                  widget.isRowsPlaceholderPinned
                      ? widget.rowsPlaceholder!
                      : SingleChildScrollView(
                          physics: widget.horizontalScrollPhysics,
                          controller: _tableControllers.rowsPlaceholderHorizontalScrollController,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: SizedBox(
                            width: _tableWidth,
                            child: widget.rowsPlaceholder,
                          ),
                        ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: widget.horizontalScrollPhysics,
                    controller: _tableControllers.horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: SizedBox(
                      width: _tableWidth,
                      child: _buildRows(),
                    ),
                  ),
                ),
                if (widget.isFooterPinned && widget.footer != null)
                  SingleChildScrollView(
                    physics: widget.horizontalScrollPhysics,
                    controller: _tableControllers.footerHorizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: _buildFooter(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TableRowLabel extends StatelessWidget {
  final MoonTableRowLabel label;
  final TextStyle labelTextStyle;
  final TextStyle animatedLabelTextStyle;
  final ScrollController horizontalScrollController;

  const _TableRowLabel({
    required this.label,
    required this.labelTextStyle,
    required this.animatedLabelTextStyle,
    required this.horizontalScrollController,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveLableTextColor =
        labelTextStyle.color ?? context.moonTheme?.tableTheme.colors.rowLabelTextColor ?? MoonColors.light.textPrimary;

    final Color effectiveAnimatedLabelTextColor = animatedLabelTextStyle.color ??
        context.moonTheme?.tableTheme.colors.rowPinnedAnimatedLabelTextColor ??
        MoonColors.light.trunks;

    final Duration effectiveTransitionDuration = label.transitionDuration ??
        context.moonTheme?.tableTheme.properties.transitionDuration ??
        const Duration(milliseconds: 400);

    final Curve effectiveTransitionCurve = label.transitionCurve ??
        context.moonTheme?.tableTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final TextStyle resolvedLabelTextStyle = labelTextStyle.copyWith(color: effectiveLableTextColor);

    final TextStyle resolvedAnimatedLabelTextStyle =
        animatedLabelTextStyle.copyWith(color: effectiveAnimatedLabelTextColor);

    return label.pinned
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
                child: MoonAnimatedDefaultTextStyle(
                  textStyle: offsetIsIncreasing ? resolvedAnimatedLabelTextStyle : resolvedLabelTextStyle,
                  curve: effectiveTransitionCurve,
                  duration: effectiveTransitionDuration,
                  child: child!,
                ),
              );
            },
            child: label.label,
          )
        : DefaultTextStyle(
            style: resolvedLabelTextStyle,
            child: label.label,
          );
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
