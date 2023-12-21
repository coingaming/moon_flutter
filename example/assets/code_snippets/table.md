import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

const int _rowsCount = 50;

class Table extends StatefulWidget {
  const Table({super.key});

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  late List<_TableData> _tableData;

  final List<String> _columnNames = ['ID', 'First name', 'Last name', 'Age', 'Activity'];
  final List<bool> _columnSorting = List.generate(5, (int _) => true);

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  List<_TableData> _generateTableData() {
    return List<_TableData>.generate(
      _rowsCount,
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

  void _onSort(int columnIndex, bool sortAscending) {
    if (_sortColumnIndex == columnIndex || _sortAscending != sortAscending) {
      setState(() {
        if (columnIndex == _sortColumnIndex) {
          _sortAscending = _columnSorting[columnIndex] = sortAscending;
        } else {
          _sortColumnIndex = columnIndex;
          _sortAscending = _columnSorting[columnIndex];
        }

        switch (columnIndex) {
          case 0: _tableData.sort((a, b) => a.id.compareTo(b.id));
          case 1: _tableData.sort((a, b) => a.firstName.compareTo(b.firstName));
          case 2: _tableData.sort((a, b) => a.lastName.compareTo(b.lastName));
          case 3: _tableData.sort((a, b) => a.age.compareTo(b.age));
          case 4: _tableData.sort((a, b) => a.activity.compareTo(b.activity));
        }

        if (!_sortAscending) _tableData = _tableData.reversed.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _tableData = _generateTableData();
  }

  MoonTableHeader _generateTableHeader() {
    return MoonTableHeader(
      columns: List.generate(
        5,
        (int index) => MoonTableColumn(
          onSort: (int columnIndex, bool sortAscending) => _onSort(columnIndex, sortAscending),
          cell: Text(_columnNames[index]),
        ),
      ),
    );
  }

  List<MoonTableRow> _generateTableRows() {
    return List.generate(
      _rowsCount,
      (int index) => MoonTableRow(
        cells: [
          Text(_tableData[index].id.toString()),
          Text(_tableData[index].firstName),
          Text(_tableData[index].lastName),
          Text(_tableData[index].age.toString()),
          Text(_tableData[index].activity.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: MediaQuery.of(context).size.width,
      child: MoonTable(
        columnsCount: 5,
        width: 564,
        rowSize: MoonTableRowSize.sm,
        tablePadding: const EdgeInsets.symmetric(horizontal: 16),
        sortAscending: _sortAscending,
        sortColumnIndex: _sortColumnIndex,
        header: _generateTableHeader(),
        rows: _generateTableRows(),
      ),
    );
  }
}

class _TableData {
  bool selected;
  int age;
  int activity;
  int id;
  String firstName;
  String lastName;

  _TableData({
    required this.selected,
    required this.age,
    required this.activity,
    required this.id,
    required this.firstName,
    required this.lastName,
  });
}
