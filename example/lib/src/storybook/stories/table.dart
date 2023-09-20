import 'dart:math';

import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<_ExampleTableData> _exampleTableData = _generateTableData();
List<String> _columnNames = ['ID', 'First name', 'Last name', 'Age', 'Activity'];
List<bool> _sortingList = List.generate(6, (int _) => true);

bool _sortAscending = true;
int _sortColumnIndex = 0;

bool _checkAllBoxes = false;

// Knob variables for methods to use outside TableStory.
bool _showCheckboxes = false;
bool _showDividerKnob = false;
bool _selectableKnob = false;
bool _zebraStyleKnob = false;
Color? _rowColor;
Color? _selectedRowColor;
Color? _textColor;
int? _borderRadiusKnob;

class TableStory extends Story {
  TableStory()
      : super(
          name: "Table",
          builder: (BuildContext context) {
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
              description: "Row gap for MoonTable rows.",
              enabled: false,
              initial: 4,
              max: 16,
            );

            final fixedHeaderKnob = context.knobs.boolean(
              label: "isFixedHeader",
              description: "Show MoonTable with fixed header.",
              initial: true,
            );

            final fixedFooterKnob = context.knobs.boolean(
              label: "isFixedFooter",
              description: "Show MoonTable with fixed footer.",
              initial: true,
            );

            _zebraStyleKnob = context.knobs.boolean(
              label: "Zebra style rows",
              description: "Show MoonTable rows with zebra style.",
            );

            _selectableKnob = context.knobs.boolean(
              label: "Selectable",
              description: "Row onSelectChanged() is not null.",
              initial: true,
            );

            final showCheckboxesKnob = context.knobs.boolean(
              label: "With checkboxes",
              description: "Show MoonTable with checkboxes.",
              initial: true,
            );

            _showDividerKnob = context.knobs.boolean(
              label: "With cell divider",
              description: "Show MoonTable with cell dividers.",
              initial: true,
            );

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                final double verticalCellPadding = tableRowSizeKnob == MoonTableRowSize.xs ? 4 : 8;

                if (_showCheckboxes != showCheckboxesKnob) {
                  _showCheckboxes = showCheckboxesKnob;
                  _sortColumnIndex = showCheckboxesKnob ? _sortColumnIndex + 1 : _sortColumnIndex - 1;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 64.0),
                  child: MoonTable(
                    hasFixedHeader: fixedHeaderKnob,
                    hasFixedFooter: fixedFooterKnob,
                    sortAscending: _sortAscending,
                    sortColumnIndex: _sortColumnIndex,
                    rowGap: rowGapKnob?.toDouble(),
                    // hasFixedPaginationPlaceHolder: false,
                    // hasFixedRowsPlaceHolder: false,
                    // paginationPlaceHolder: Padding(
                    //   padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                    //   child: Row(
                    //     children: [
                    //       MoonButton.icon(
                    //         icon: const MoonIcon(MoonIcons.chevron_left_16),
                    //         backgroundColor: context.moonColors!.beerus,
                    //       ),
                    //       const Spacer(),
                    //       const Text('1-20 of 4396'),
                    //       const Spacer(),
                    //       MoonButton.icon(
                    //         icon: const MoonIcon(MoonIcons.chevron_right_16),
                    //         backgroundColor: context.moonColors!.beerus,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    rowSeparatorWidget: Container(height: 1, color: context.moonColors!.chiChi60),
                    // rowsPlaceHolder: const Text('No data to show'),
                    tableHeader: _generateTableHeader(context, setState),
                    tableFooter: _generateTableFooter(context),
                    tableRows: _generateTableRows(context, setState),
                    cellPadding: EdgeInsetsDirectional.fromSTEB(16, verticalCellPadding, 0, verticalCellPadding),
                    // rowSize: tableRowSizeKnob ?? MoonTableRowSize.md,
                  ),
                );
              },
            );
          },
        );
}

Widget _buildCell(BuildContext context, dynamic label, {bool firstCell = false}) {
  return DecoratedBox(
    decoration: _showDividerKnob && !firstCell
        ? BoxDecoration(
            border: Border(
              left: Divider.createBorderSide(
                context,
                color: context.moonColors!.beerus,
              ),
            ),
          )
        : const BoxDecoration(),
    child: Padding(
      padding: EdgeInsetsDirectional.only(start: firstCell ? 0 : 16),
      child: Text(
        label.toString(),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: _textColor,
        ),
      ),
    ),
  );
}

MoonTableHeader _generateTableHeader(BuildContext context, StateSetter setState) {
  return MoonTableHeader(
    columns: List.generate(
      _showCheckboxes ? 6 : 5,
      (index) {
        final bool hasCheckboxColumn = index == 0 && _showCheckboxes;
        double columnWidth = 128;

        if (index == 0 && !_showCheckboxes || index == 1 && _showCheckboxes) {
          columnWidth = 72;
        } else if (index == 0 && _showCheckboxes) {
          columnWidth = 56;
        }

        return MoonTableColumn(
          columnWidth: columnWidth,
          onTap: () {
            if (index == 0 && _showCheckboxes) {
              setState(() {
                _checkAllBoxes = !_checkAllBoxes;

                for (int i = 0; i < _exampleTableData.length; i++) {
                  _exampleTableData[i].selected = _checkAllBoxes;
                }
              });
            }
          },
          onSort: hasCheckboxColumn
              ? null
              : (int columnIndex, bool sortAscending) => {
                    setState(() {
                      if (columnIndex == _sortColumnIndex) {
                        _sortAscending = _sortingList[columnIndex] = sortAscending;
                      } else {
                        _sortColumnIndex = columnIndex;
                        _sortAscending = _sortingList[columnIndex];
                      }
                      switch (_showCheckboxes ? columnIndex : columnIndex + 1) {
                        case 1:
                          _exampleTableData.sort((a, b) => a.id.compareTo(b.id));
                        case 2:
                          _exampleTableData.sort((a, b) => a.firstName.compareTo(b.firstName));
                        case 3:
                          _exampleTableData.sort((a, b) => a.lastName.compareTo(b.lastName));
                        case 4:
                          _exampleTableData.sort((a, b) => a.age.compareTo(b.age));
                        case 5:
                          _exampleTableData.sort((a, b) => a.activity.compareTo(b.activity));
                      }
                      if (!_sortAscending) _exampleTableData = _exampleTableData.reversed.toList();
                    }),
                  },
          cell: hasCheckboxColumn
              ? MoonCheckbox(
                  tapAreaSizeValue: 0,
                  value: _checkAllBoxes,
                  onChanged: (bool? onChanged) {
                    if (onChanged != null) {
                      setState(() {
                        _checkAllBoxes = onChanged;

                        for (int i = 0; i < _exampleTableData.length; i++) {
                          _exampleTableData[i].selected = _checkAllBoxes;
                        }
                      });
                    }
                  },
                )
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

List<MoonTableRow> _generateTableRows(BuildContext context, StateSetter setState) {
  return List.generate(
    30,
    (index) {
      final row = _exampleTableData[index];

      return MoonTableRow(
        selected: row.selected,
        onSelectChanged: _selectableKnob == false
            ? null
            : (bool? selected) => {
                  if (selected != null) setState(() => row.selected = selected),
                },
        rowDecoration: ShapeDecorationWithPremultipliedAlpha(
          color: _zebraStyleKnob
              ? row.selected
                  ? _selectedRowColor ?? context.moonColors!.beerus
                  : index.isEven
                      ? _rowColor ?? context.moonColors!.gohan
                      : Colors.transparent
              : row.selected
                  ? _selectedRowColor ?? context.moonColors!.beerus
                  : _rowColor ?? context.moonColors!.gohan,
          shape: MoonSquircleBorder(
            borderRadius: _borderRadiusKnob != null
                ? BorderRadius.circular(_borderRadiusKnob!.toDouble()).squircleBorderRadius(context)
                : BorderRadius.circular(8).squircleBorderRadius(context),
          ),
        ),
        rowTitle: MoonTableRowTitle(
          title: Text(_exampleTableData[index].colStickyTitle),
        ),
        cells: [
          if (_showCheckboxes)
            MoonCheckbox(
              tapAreaSizeValue: 0,
              value: row.selected,
              onChanged: (bool? onChanged) {
                if (onChanged != null) setState(() => setState(() => row.selected = !row.selected));
              },
            ),
          _buildCell(context, _exampleTableData[index].id, firstCell: !_showCheckboxes),
          _buildCell(context, _exampleTableData[index].firstName),
          _buildCell(context, _exampleTableData[index].lastName),
          _buildCell(context, _exampleTableData[index].age),
          _buildCell(context, _exampleTableData[index].activity),
        ],
      );
    },
  );
}

MoonTableFooter _generateTableFooter(BuildContext context) {
  return MoonTableFooter(
    cells: List.generate(_showCheckboxes ? 6 : 5, (index) {
      final int ageColumn = _showCheckboxes ? 4 : 3;
      final int activityColumn = _showCheckboxes ? 5 : 4;

      String label = '30';

      if (index == 0) {
        label = 'Total:';
      } else if (index == ageColumn || index == activityColumn) {
        label = _exampleTableData
            .map((item) => index == ageColumn ? item.age : item.activity)
            .reduce((value, element) => value + element)
            .toString();
      }

      return _buildCell(context, label, firstCell: index == 0);
    }),
  );
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
    30,
    (index) => _ExampleTableData(
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
