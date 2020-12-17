import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class AllPrizeBondsScreen extends StatefulWidget {
  final List<PrizeBond> allPrizeBonds;

  const AllPrizeBondsScreen({Key key, this.allPrizeBonds}) : super(key: key);

  @override
  _AllPrizeBondsScreenState createState() => _AllPrizeBondsScreenState();
}

class _AllPrizeBondsScreenState extends State<AllPrizeBondsScreen> {
  List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(widget.allPrizeBonds.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getBody(),
    );
  }

  Widget _getBody() {
    if (widget.allPrizeBonds.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(NO_PRIZEBOND_IN_DB),
          SizedBox(height: 8),
          Text(ADD_PRIZEBOND_IN_DB),
        ],
      );
    }

    return DataTable(
      showCheckboxColumn: false,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      columns: [
        DataColumn(label: Text(SERIAL)),
        DataColumn(label: Text(PRIZEBOND_NUMBER)),
        DataColumn(label: Text(DATE_CREATED)),
        DataColumn(label: Text(DATE_UPDATED)),
        DataColumn(label: Text(ACTIONS)),
      ],
      rows: List<DataRow>.generate(
        widget.allPrizeBonds.length,
        (index) {
          String _startDate = widget.allPrizeBonds[index].insertDate;
          String _updateDate = widget.allPrizeBonds[index].updateDate;
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
              DataCell(Center(child: Text('${widget.allPrizeBonds[index].prizeBondNumber}'))),
              DataCell(Center(child: Text('$_startDate'))),
              DataCell(Center(child: Text('$_updateDate'))),
              DataCell(IconButton(
                alignment: Alignment.center,
                icon: Icon(Icons.delete_forever, color: Colors.red),
                onPressed: () => print("Deleting ${widget.allPrizeBonds[index].id}..."),
              )),
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
}
