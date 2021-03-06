import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/data_store/data_store.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class AllPrizeBondsScreen extends StatefulWidget {
  @override
  _AllPrizeBondsScreenState createState() => _AllPrizeBondsScreenState();
}

class _AllPrizeBondsScreenState extends State<AllPrizeBondsScreen> {
  List<bool> _selected;
  bool _isAsc = true;
  int _sortColumnIndex = 1;
  DataStore _dataStore;
  List<PrizeBond> _allBondsToShow;

  @override
  void initState() {
    super.initState();
    _dataStore = RepositoryProvider.of<DataStore>(context);
    _allBondsToShow = _dataStore.numericallySortedPrizeBonds;
    _selected = List<bool>.generate(_allBondsToShow.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getBody(),
    );
  }

  Widget _getBody() {
    if (_allBondsToShow.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(NO_PRIZEBOND_IN_DB),
          SizedBox(height: 8),
          Text(ADD_PRIZEBOND_IN_DB),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getSearchBox(),
          SizedBox(height: 12.0),
          _getDataTable(),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }

  Widget _getSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          autofocus: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
            hintText: SEARCH_PRIZEBONDS,
          ),
        ),
        suggestionsCallback: (pattern) async {
          return _dataStore.searchPrizeBond(pattern);
        },
        itemBuilder: (context, suggestion) {
          String _startDate = suggestion.insertDate;
          String _updateDate = suggestion.updateDate;
          _startDate = _startDate == "" ? "" : "Created on: " + DateFormat.yMMMMd('en_US').format(DateTime.parse(_startDate));
          _updateDate = _updateDate == "" ? "Never Updated" : "Updated on" + DateFormat.yMMMMd('en_US').format(DateTime.parse(_updateDate));

          return ListTile(
            leading: Icon(Icons.money),
            title: Text("Bond Number: ${suggestion.prizeBondNumber}"),
            subtitle: Text('$_updateDate'),
            trailing: Text('$_startDate'),
          );
        },
        onSuggestionSelected: (suggestion) {
          print(suggestion);
        },
      ),
    );
  }

  Widget _getDataTable() {
    return DataTable(
      showCheckboxColumn: false,
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _isAsc,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      columns: [
        DataColumn(label: Text(SERIAL)),
        DataColumn(
          label: Text(PRIZEBOND_NUMBER),
          onSort: (columnIndex, isAsc) {
            setState(() {
              if (columnIndex == _sortColumnIndex) {
                _isAsc = isAsc;
              } else {
                _sortColumnIndex = columnIndex;
                _isAsc = isAsc;
              }
              _allBondsToShow = _dataStore.numericallySortedPrizeBonds;
              if (!_isAsc) _allBondsToShow = _allBondsToShow.reversed.toList();
            });
          },
        ),
        DataColumn(
          label: Text(DATE_CREATED),
          onSort: (columnIndex, isAsc) {
            setState(() {
              if (columnIndex == _sortColumnIndex) {
                _isAsc = isAsc;
              } else {
                _sortColumnIndex = columnIndex;
                _isAsc = isAsc;
              }
              _allBondsToShow = _dataStore.createDateWiseSortedPrizeBonds;
              if (!_isAsc) _allBondsToShow = _allBondsToShow.reversed.toList();
            });
          },
        ),
        DataColumn(
          label: Text(DATE_UPDATED),
          onSort: (columnIndex, isAsc) {
            setState(() {
              if (columnIndex == _sortColumnIndex) {
                _isAsc = isAsc;
              } else {
                _sortColumnIndex = columnIndex;
                _isAsc = isAsc;
              }
              _allBondsToShow = _dataStore.updateDateWiseSortedPrizeBonds;
              if (!_isAsc) _allBondsToShow = _allBondsToShow.reversed.toList();
            });
          },
        ),
        DataColumn(label: Text(ACTIONS)),
      ],
      rows: List<DataRow>.generate(
       _allBondsToShow.length,
        (index) {
          String _startDate = _allBondsToShow[index].insertDate;
          String _updateDate = _allBondsToShow[index].updateDate;
          _startDate = _startDate == "" ? "-" : DateFormat.yMMMMd('en_US').format(DateTime.parse(_startDate));
          _updateDate = _updateDate == "" ? "-" : DateFormat.yMMMMd('en_US').format(DateTime.parse(_updateDate));

          return DataRow(
            color: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
                return null;
              }),
            cells: [
              DataCell(Center(child: Text('${index+1}'))),
              DataCell(Center(child: Text('${_allBondsToShow[index].prizeBondNumber}'))),
              DataCell(Center(child: Text('$_startDate'))),
              DataCell(Center(child: Text('$_updateDate'))),
              DataCell(_getActions(index)),
            ],
            selected: _selected[index],
            onSelectChanged: (bool value) {
              setState(() {
                _selected[index] = value;
              });
            },
          );
        },
      ),
    );
  }

  _getActions(int index) {
    return Row(
      children: [
        IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.edit_outlined, color: Colors.green),
          onPressed: () => print("editing ${_allBondsToShow[index].id}..."),
        ),
        IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.delete_forever, color: Colors.red),
          onPressed: () => print("Deleting ${_allBondsToShow[index].id}..."),
        ),
      ],
    );
  }
}
