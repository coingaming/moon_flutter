import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

const int _rowsInPage = 25;

@RoutePage()
class TableStory extends StatefulWidget {
  const TableStory({super.key});

  @override
  State<TableStory> createState() => _TableStoryState();
}

class _TableStoryState extends State<TableStory> {
  final List<_ExampleTableData> _exampleTableData = _generateTableData();
  late List<_ExampleTableData> _exampleTableDataToShow;

  final List<String> _columnNames = ['ID', 'First name', 'Last name', 'Age', 'Activity'];
  final List<bool> _columnSorting = List.generate(6, (int _) => true);

  bool _checkAllBoxes = false;
  bool _sortAscending = true;
  int _sortColumnIndex = 0;
  int _rowsToShow = _rowsInPage;

  bool _showCheckboxes = false;
  bool _showDividerKnob = false;
  bool _rowsSelectableKnob = false;
  bool _zebraStyleKnob = false;
  bool _infiniteScrollKnob = false;
  Color? _rowColor;
  Color? _selectedRowColor;
  Color? _textColor;
  int? _borderRadiusKnob;

  void _scrollListener(StateSetter setState, ScrollController verticalScrollController) {
    verticalScrollController.addListener(() {
      if (verticalScrollController.hasClients && _infiniteScrollKnob) {
        final double pixels = verticalScrollController.position.pixels;
        final double maxScrollExtent = verticalScrollController.position.maxScrollExtent;

        if (pixels >= maxScrollExtent && _rowsToShow < _rowsInPage * 5) {
          _exampleTableDataToShow += _exampleTableData.sublist(_rowsToShow, _rowsToShow + _rowsInPage);

          setState(() => _rowsToShow += _rowsInPage);
        }
      }
    });
  }

  void _onSort(StateSetter setState, int columnIndex, bool sortAscending) {
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
            _exampleTableDataToShow.sort((a, b) => a.id.compareTo(b.id));
          case 2:
            _exampleTableDataToShow.sort((a, b) => a.firstName.compareTo(b.firstName));
          case 3:
            _exampleTableDataToShow.sort((a, b) => a.lastName.compareTo(b.lastName));
          case 4:
            _exampleTableDataToShow.sort((a, b) => a.age.compareTo(b.age));
          case 5:
            _exampleTableDataToShow.sort((a, b) => a.activity.compareTo(b.activity));
        }
        if (!_sortAscending) _exampleTableDataToShow = _exampleTableDataToShow.reversed.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _exampleTableDataToShow = _exampleTableData.sublist(0, _rowsInPage);
  }

  Widget _headerCheckBox(StateSetter setState) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      child: MoonCheckbox(
        tapAreaSizeValue: 0,
        value: _checkAllBoxes,
        onChanged: _rowsSelectableKnob
            ? (bool? onChanged) => onChanged != null
                ? setState(() {
                    _checkAllBoxes = onChanged;
                    for (final item in _exampleTableDataToShow) {
                      item.selected = _checkAllBoxes;
                    }
                  })
                : null
            : null,
      ),
    );
  }

  Widget _buildCell(BuildContext context, dynamic label, {bool firstCell = false}) {
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

  MoonTableHeader _generateTableHeader(BuildContext context, StateSetter setState) {
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

                  for (final item in _exampleTableDataToShow) {
                    item.selected = _checkAllBoxes;
                  }
                });
              }
            },
            onSort: checkboxColumn
                ? null
                : (int columnIndex, bool sortAscending) => _onSort(setState, columnIndex, sortAscending),
            cell: checkboxColumn
                ? _headerCheckBox(setState)
                : _buildCell(
                    context,
                    _columnNames[_showCheckboxes ? index - 1 : index],
                    firstCell: index == 0 && !_showCheckboxes,
                  ),
          );
        },
      ),
    );
  }

  MoonTableFooter _generateTableFooter(BuildContext context) {
    return MoonTableFooter(
      cells: List.generate(
        _showCheckboxes ? 6 : 5,
        (int index) {
          final int ageColumnIndex = _showCheckboxes ? 4 : 3;
          final int activityColumnIndex = _showCheckboxes ? 5 : 4;

          final String label = index == 0
              ? 'Total:'
              : (index == ageColumnIndex || index == activityColumnIndex)
                  ? _exampleTableDataToShow
                      .map((_ExampleTableData item) => index == ageColumnIndex ? item.age : item.activity)
                      .reduce((int value, int element) => value + element)
                      .toString()
                  : '-';

          return _buildCell(context, label, firstCell: index == 0);
        },
      ),
    );
  }

  List<MoonTableRow> _generateTableRows(BuildContext context, StateSetter setState) {
    return List.generate(
      _rowsToShow,
      (int index) {
        final row = _exampleTableDataToShow[index];

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
            _buildCell(context, _exampleTableDataToShow[index].id, firstCell: !_showCheckboxes),
            _buildCell(context, _exampleTableDataToShow[index].firstName),
            _buildCell(context, _exampleTableDataToShow[index].lastName),
            _buildCell(context, _exampleTableDataToShow[index].age),
            _buildCell(context, _exampleTableDataToShow[index].activity),
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
      description: "Row gap between MoonTable rows.",
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
        _exampleTableDataToShow = _exampleTableData.sublist(0, _rowsInPage);
        _rowsToShow = _rowsInPage;
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
          header: _generateTableHeader(context, setState),
          footer: _generateTableFooter(context),
          rows: _generateTableRows(context, setState),
          tablePadding: const EdgeInsets.symmetric(horizontal: 16),
          cellPadding: EdgeInsets.symmetric(vertical: tableRowSizeKnob == MoonTableRowSize.xs ? 4 : 8),
          onScrollControllersReady: (
            ScrollController verticalScrollController,
            ScrollController horizontalScrollController,
          ) =>
              _scrollListener(setState, verticalScrollController),
        ),
      ),
    );
  }
}

class _ExampleTableData {
  bool selected;
  int id;
  String firstName;
  String lastName;
  int age;
  int activity;
  String colStickyTitle;

  _ExampleTableData({
    required this.selected,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.activity,
    required this.colStickyTitle,
  });
}

List<_ExampleTableData> _generateTableData() {
  return List<_ExampleTableData>.generate(
    _rowsInPage * 5,
    (int index) => _ExampleTableData(
      id: index,
      selected: false,
      firstName: 'Test$index',
      lastName: 'Subject$index',
      age: Random().nextInt(81),
      activity: Random().nextInt(100),
      colStickyTitle: 'Sticky title $index',
    ),
  );
}
