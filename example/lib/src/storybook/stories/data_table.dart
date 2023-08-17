//             return StatefulBuilder(
//               builder: (context, setState) {
//                 final List<MoonDataRow> exampleRows = _exampleTableData
//                     .map(
//                       (row) => MoonDataRow(
//                         onTap: () => print('Row ${row.colA} tapped'),
//                         selected: checkboxIsSelected ?? false,
//                         onSelectChanged: (bool? isSelected) => {
//                           if (isSelected != null) setState(() => checkboxIsSelected = isSelected),
//                           print('Row ${row.colA} selected: $isSelected'),
//                         },
//                         cells: [
//                           MoonDataCell(Text(row.colA)),
//                           MoonDataCell(Text(row.colB)),
//                           MoonDataCell(Text(row.colC)),
//                           MoonDataCell(Text(row.colD)),
//                         ],
//                       ),
//                     )
//                     .toList();
//
//                 return SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 64),
//                     child: MoonDataTable(
//                       sortAscending: _sortAscending,
//                       sortColumnIndex: _sortColumnIndex,
//                       isHorizontalScrollBarVisible: false,
//                       isVerticalScrollBarVisible: false,
//                       sortArrowIcon: MoonIcons.chevron_down_16,
//                       columnSpacing: 16,
//                       rowSpacing: 8,
//                       placeHolder: const Text('No data'),
//                       horizontalMargin: 16,
//                       // showCellDivider: true,
//                       evenRowColor: context.moonColors!.chiChi60,
//                       minTableWidth: 600,
//                       // headingRowColor: MaterialStatePropertyAll(Colors.blueGrey),
//                       // dataRowColor: MaterialStatePropertyAll(Colors.pink),
//                       fixedCornerColor: Colors.blueGrey,
//                       fixedColumnsColor: Colors.blueGrey,
//                       // checkboxHorizontalMargin: 50,
//                       rows: exampleRows,
//                       // dividerThickness: 14,
//                       // showBottomBorder: true,
//                       fixedLeftColumns: 2,
//                       fixedTopRows: 3,

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

bool? checkboxIsSelected = false;

List<bool> sortingList = [true, true, true, true];
bool _sortAscending = true;
int _sortColumnIndex = 0;

List<_ExampleTableData> _exampleTableData = List<_ExampleTableData>.generate(
  10,
  (index) => _ExampleTableData(
    colA: 'Column A$index',
    colB: 'Column B$index',
    colC: 'Column C$index',
    colD: 'Column D$index',
    colSticky: 'Sticky header A$index',
  ),
);

class DataTableStory extends Story {
  DataTableStory()
      : super(
          name: "DataTable",
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                Widget getRowCellWidget(String label, double width, {double? height}) {
                  return Container(
                    // width: width,
                    height: height,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    alignment: Alignment.centerLeft,
                    child: Text(label, style: MoonTypography.typography.body.text12),
                  );
                }

                MoonTableHeader generateHeaderRow() {
                  return MoonTableHeader(
                    rowHeight: 56,
                    onSort: (int columnIndex, bool sortAscending) => {
                      setState(() {
                        if (columnIndex == _sortColumnIndex) {
                          _sortAscending = sortingList[columnIndex] = sortAscending;
                        } else {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = sortingList[columnIndex];
                        }
                        switch (columnIndex) {
                          case 0:
                            _exampleTableData.sort((a, b) => a.colA.compareTo(b.colA));
                          case 1:
                            _exampleTableData.sort((a, b) => a.colB.compareTo(b.colB));
                          case 2:
                            _exampleTableData.sort((a, b) => a.colC.compareTo(b.colC));
                          case 3:
                            _exampleTableData.sort((a, b) => a.colD.compareTo(b.colD));
                        }
                        if (!_sortAscending) _exampleTableData = _exampleTableData.reversed.toList();
                      }),
                    },
                    headerItemsList: [
                      getRowCellWidget('Column A', 150, height: 56),
                      getRowCellWidget('Column B', 150, height: 56),
                      getRowCellWidget('Column C', 150, height: 56),
                      getRowCellWidget('Column D', 150, height: 56),
                    ],
                  );
                }

                // List<Widget> generateHeaderRow() {
                //   return [
                //     getRowItemWidget('Column A', 150, height: 56),
                //     getRowItemWidget('Column B', 150, height: 56),
                //     getRowItemWidget('Column C', 150, height: 56),
                //     getRowItemWidget('Column D', 150, height: 56),
                //   ];
                // }

                MoonTableRow generateBodyRow() {
                  return MoonTableRow(
                    rowHeight: 56,
                    selected: checkboxIsSelected ?? false,
                    onSelectChanged: (bool? selected) => {
                      debugPrint('$selected'),
                      setState(() => checkboxIsSelected = selected),
                    },
                    rowDecoration: ShapeDecorationWithPremultipliedAlpha(
                      color: checkboxIsSelected ?? false ? context.moonColors!.beerus : context.moonColors!.gohan,
                      shape: MoonSquircleBorder(
                        borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                      ),
                    ),
                    rowStickyTitleBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(_exampleTableData[index].colSticky),
                    ),
                    rowBuilder: (BuildContext context, int index) => Container(

                      child: Row(
                        children: <Widget>[
                          getRowCellWidget(_exampleTableData[index].colA, 150),
                          getRowCellWidget(_exampleTableData[index].colB, 150),
                          getRowCellWidget(_exampleTableData[index].colC, 150),
                          getRowCellWidget(_exampleTableData[index].colD, 150),
                        ],
                      ),
                    ),
                    onTap: () => debugPrint('Row tapped'),
                  );
                }

                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return MoonDataTable(
                          tableWidth: 650,
                          // isFixedHeader: true,
                          // headerWidgets: generateHeaderRow(),
                          placeHolder: const Align(
                            alignment: Alignment.topCenter,
                            child: Text('nothing to show'),
                          ),
                          tableHeader: generateHeaderRow(),
                          tableRow: generateBodyRow(),
                          // rowSeparatorWidget: const Divider(color: Colors.black, height: 1.0),
                          tableBackgroundColor: Colors.pink,
                          tablePadding: const EdgeInsetsDirectional.all(4),
                          rowsCount: 10,
                          gap: 4,
                          columnsCount: 4,
                          sortAscending: _sortAscending,
                          sortColumnIndex: _sortColumnIndex,
                          sortArrowIcon: MoonIcons.chevron_down_16,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
}

class _ExampleTableData {
  String colA;
  String colB;
  String colC;
  String colD;
  String colSticky;

  _ExampleTableData({
    required this.colA,
    required this.colB,
    required this.colC,
    required this.colD,
    required this.colSticky,
  });
}
