import 'dart:math';

import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const int _rowsPerPage = 25;

class TableStory extends StatefulWidget {
  static const path = '/table';

  const TableStory({super.key});

  @override
  State<TableStory> createState() => _TableStoryState();
}

class _TableStoryState extends State<TableStory> {
  late final List<_TableData> _tableDataOriginal;
  late List<_TableData> _tableDataToShow;

  final List<String> _columnNames = ['ID', 'First name', 'Last name', 'Age', 'Activity'];
  final List<bool> _columnSorting = List.generate(6, (int _) => true);

  bool _checkAllBoxes = false;
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  int _rowsToShow = _rowsPerPage;

  bool _showCheckboxes = false;
  bool _showDividerKnob = false;
  bool _rowsSelectableKnob = false;
  bool _zebraStyleKnob = false;
  bool _infiniteScrollKnob = false;
  Color? _rowColor;
  Color? _selectedRowColor;
  Color? _textColor;
  int? _borderRadiusKnob;

  List<_TableData> _generateTableData() {
    return List<_TableData>.generate(
      _rowsPerPage * 5,
      (int index) => _TableData(
        id: index,
        selected: false,
        firstName: 'Test$index',
        lastName: 'Subject$index',
        age: Random().nextInt(81),
        activity: Random().nextInt(100),
      ),
    );
  }

  void _scrollListener(ScrollController verticalScrollController) {
    verticalScrollController.addListener(() {
      if (verticalScrollController.hasClients && _infiniteScrollKnob) {
        final double pixels = verticalScrollController.position.pixels;
        final double maxScrollExtent = verticalScrollController.position.maxScrollExtent;

        if (pixels >= maxScrollExtent && _rowsToShow < _rowsPerPage * 5) {
          _tableDataToShow += _tableDataOriginal.sublist(_rowsToShow, _rowsToShow + _rowsPerPage);

          setState(() => _rowsToShow += _rowsPerPage);
        }
      }
    });
  }

  void _onSort(int columnIndex, bool sortAscending) {
    if (_sortColumnIndex == columnIndex || _sortAscending != sortAscending) {
      setState(() {
        if (columnIndex == _sortColumnIndex) {
          _sortAscending = _columnSorting[columnIndex] = sortAscending;
        } else {
          _sortColumnIndex = columnIndex;
          _sortAscending = _columnSorting[columnIndex];
        }

        switch (_showCheckboxes ? columnIndex : columnIndex + 1) {
          case 1:
            _tableDataToShow.sort((a, b) => a.id.compareTo(b.id));
          case 2:
            _tableDataToShow.sort((a, b) => a.firstName.compareTo(b.firstName));
          case 3:
            _tableDataToShow.sort((a, b) => a.lastName.compareTo(b.lastName));
          case 4:
            _tableDataToShow.sort((a, b) => a.age.compareTo(b.age));
          case 5:
            _tableDataToShow.sort((a, b) => a.activity.compareTo(b.activity));
        }

        if (!_sortAscending) _tableDataToShow = _tableDataToShow.reversed.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _tableDataOriginal = _generateTableData();
    _tableDataToShow = _tableDataOriginal.sublist(0, _rowsPerPage);
  }

  Widget _headerCheckBox() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: MoonCheckbox(
        tapAreaSizeValue: 0,
        value: _checkAllBoxes,
        onChanged: _rowsSelectableKnob
            ? (bool? onChanged) => onChanged != null
                ? setState(() {
                    _checkAllBoxes = onChanged;

                    for (final item in _tableDataToShow) {
                      item.selected = _checkAllBoxes;
                    }
                  })
                : null
            : null,
      ),
    );
  }

  Widget _buildCell(dynamic label, {bool firstCell = false}) {
    return DecoratedBox(
      decoration: _showDividerKnob && !firstCell
          ? BoxDecoration(
              border: Border(
                left: Directionality.of(context) == TextDirection.ltr
                    ? Divider.createBorderSide(context, color: context.moonColors!.beerus, width: 1)
                    : BorderSide.none,
                right: Directionality.of(context) == TextDirection.rtl
                    ? Divider.createBorderSide(context, color: context.moonColors!.beerus, width: 1)
                    : BorderSide.none,
              ),
            )
          : const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              label.toString(),
              style: TextStyle(color: _textColor),
            ),
          ],
        ),
      ),
    );
  }

  MoonTableHeader _generateTableHeader() {
    return MoonTableHeader(
      columns: List.generate(
        _showCheckboxes ? 6 : 5,
        (int index) {
          final bool checkboxColumn = index == 0 && _showCheckboxes;
          final double columnWidth = index == 0 || index == 1 && _showCheckboxes ? 64 : 128;

          return MoonTableColumn(
            width: columnWidth,
            onTap: () {
              if (checkboxColumn && _rowsSelectableKnob) {
                setState(() {
                  _checkAllBoxes = !_checkAllBoxes;

                  for (final item in _tableDataToShow) {
                    item.selected = _checkAllBoxes;
                  }
                });
              }
            },
            onSort:
                checkboxColumn ? null : (int columnIndex, bool sortAscending) => _onSort(columnIndex, sortAscending),
            cell: checkboxColumn
                ? _headerCheckBox()
                : _buildCell(
                    _columnNames[_showCheckboxes ? index - 1 : index],
                    firstCell: index == 0 && !_showCheckboxes,
                  ),
          );
        },
      ),
    );
  }

  MoonTableFooter _generateTableFooter() {
    return MoonTableFooter(
      cells: List.generate(
        _showCheckboxes ? 6 : 5,
        (int index) {
          final int ageColumnIndex = _showCheckboxes ? 4 : 3;
          final int activityColumnIndex = _showCheckboxes ? 5 : 4;

          final String label = index == 0
              ? 'Total:'
              : (index == ageColumnIndex || index == activityColumnIndex)
                  ? _tableDataToShow
                      .map((_TableData item) => index == ageColumnIndex ? item.age : item.activity)
                      .reduce((int value, int element) => value + element)
                      .toString()
                  : '-';

          return _buildCell(label, firstCell: index == 0);
        },
      ),
    );
  }

  List<MoonTableRow> _generateTableRows() {
    return List.generate(
      _rowsToShow,
      (int index) {
        final row = _tableDataToShow[index];

        return MoonTableRow(
          selected: row.selected,
          onSelectChanged:
              _rowsSelectableKnob ? (bool? selected) => setState(() => row.selected = selected ?? false) : null,
          decoration: ShapeDecorationWithPremultipliedAlpha(
            color: _zebraStyleKnob
                ? row.selected
                    ? _selectedRowColor ?? context.moonColors!.beerus
                    : index.isEven
                        ? _rowColor ?? context.moonColors!.goku
                        : Colors.transparent
                : row.selected
                    ? _selectedRowColor ?? context.moonColors!.beerus
                    : _rowColor ?? context.moonColors!.goku,
            shape: MoonSquircleBorder(
              borderRadius: _borderRadiusKnob != null
                  ? BorderRadius.circular(_borderRadiusKnob!.toDouble()).squircleBorderRadius(context)
                  : BorderRadius.circular(8).squircleBorderRadius(context),
            ),
          ),
          cells: [
            if (_showCheckboxes)
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: MoonCheckbox(
                  tapAreaSizeValue: 0,
                  value: row.selected,
                  onChanged:
                      _rowsSelectableKnob ? (bool? onChanged) => setState(() => row.selected = !row.selected) : null,
                ),
              ),
            _buildCell(row.id, firstCell: !_showCheckboxes),
            _buildCell(row.firstName),
            _buildCell(row.lastName),
            _buildCell(row.age),
            _buildCell(row.activity),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tableRowSizeKnob = context.knobs.nullable.options(
      label: "tableRowSize",
      description: "Size variants for MoonTable.",
      enabled: false,
      initial: MoonTableRowSize.md,
      options: const [
        Option(label: "xs", value: MoonTableRowSize.xs),
        Option(label: "sm", value: MoonTableRowSize.sm),
        Option(label: "md", value: MoonTableRowSize.md),
        Option(label: "lg", value: MoonTableRowSize.lg),
        Option(label: "xl", value: MoonTableRowSize.xl),
        Option(label: "x2l", value: MoonTableRowSize.x2l),
      ],
    );

    final rowColorKnob = context.knobs.nullable.options(
      label: "Row color",
      description: "MoonColors variants for MoonTable rows.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    _rowColor = colorTable(context)[rowColorKnob ?? 40];

    final selectedRowColorKnob = context.knobs.nullable.options(
      label: "Selected row color",
      description: "MoonColors variants for MoonTable selected rows.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    _selectedRowColor = colorTable(context)[selectedRowColorKnob ?? 40];

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonTable text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    _textColor = colorTable(context)[textColorKnob ?? 40];

    _borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "Border radius",
      description: "Border radius for MoonTable row.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final rowGapKnob = context.knobs.nullable.sliderInt(
      label: "rowGap",
      description: "Gap between MoonTable rows.",
      enabled: false,
      initial: 4,
      max: 16,
    );

    final isHeaderPinnedKnob = context.knobs.boolean(
      label: "isHeaderPinned",
      description: "Show MoonTable with pinned header.",
      initial: true,
    );

    final isFooterPinnedKnob = context.knobs.boolean(
      label: "isFooterPinned",
      description: "Show MoonTable with pinned footer.",
      initial: true,
    );

    _rowsSelectableKnob = context.knobs.boolean(
      label: "Rows selectable",
      description: "Row onSelectChanged() is not null.",
      initial: true,
    );

    _zebraStyleKnob = context.knobs.boolean(
      label: "Zebra style rows",
      description: "Show MoonTable rows with zebra style.",
    );

    final showCheckboxesKnob = context.knobs.boolean(
      label: "With checkboxes",
      description: "Show MoonTable with checkboxes.",
    );

    _showDividerKnob = context.knobs.boolean(
      label: "With cell divider",
      description: "Show MoonTable with cell divider.",
    );

    final infiniteScrollKnob = context.knobs.boolean(
      label: "With infinite scroll",
      description: "Show MoonTable with infinite scroll.",
    );

    if (_showCheckboxes != showCheckboxesKnob) {
      _showCheckboxes = showCheckboxesKnob;
      _sortColumnIndex = showCheckboxesKnob ? _sortColumnIndex + 1 : _sortColumnIndex - 1;
    }

    if (_infiniteScrollKnob != infiniteScrollKnob) {
      _infiniteScrollKnob = infiniteScrollKnob;

      if (!infiniteScrollKnob) {
        _tableDataToShow = _tableDataOriginal.sublist(0, _rowsPerPage);
        _rowsToShow = _rowsPerPage;
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.0,
        bottom: 42.0,
      ),
      child: OverflowBox(
        maxWidth: MediaQuery.of(context).size.width,
        child: MoonTable(
          columnsCount: _showCheckboxes ? 6 : 5,
          isHeaderPinned: isHeaderPinnedKnob,
          isFooterPinned: isFooterPinnedKnob,
          sortAscending: _sortAscending,
          sortColumnIndex: _sortColumnIndex,
          rowGap: rowGapKnob?.toDouble(),
          rowSize: tableRowSizeKnob ?? MoonTableRowSize.md,
          header: _generateTableHeader(),
          footer: _generateTableFooter(),
          rows: _generateTableRows(),
          tablePadding: const EdgeInsets.symmetric(horizontal: 16),
          cellPadding: EdgeInsets.symmetric(vertical: tableRowSizeKnob == MoonTableRowSize.xs ? 4 : 8),
          onScrollControllersReady: (
            ScrollController verticalScrollController,
            ScrollController horizontalScrollController,
          ) =>
              _scrollListener(verticalScrollController),
        ),
      ),
    );
  }
}

class _TableData {
  bool selected;
  int id;
  String firstName;
  String lastName;
  int age;
  int activity;

  _TableData({
    required this.selected,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.activity,
  });
}
