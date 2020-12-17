import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

import 'prizebond_bloc/prizebond_bloc.dart';
import 'prizebond_bloc/prizebond_event.dart';

class AddPrizeBondsScreen extends StatefulWidget {
  final PrizeBondManagerBloc prizeBondManagerBloc;

  const AddPrizeBondsScreen({Key key, this.prizeBondManagerBloc}) : super(key: key);

  @override
  _AddPrizeBondsScreenState createState() => _AddPrizeBondsScreenState();
}

class _AddPrizeBondsScreenState extends State<AddPrizeBondsScreen> {
  TextEditingController _controller;
  List<String> _error = [];
  final List<String> _rules = [
    "1. To add a single number, just type the number like: 0012345",
    "2. To add multiple numbers, separate them with comma like: 0012345, 9876543",
    "3. To add a series of numbers, use ~ like: 0012345~0012360",
    "4. You can combine all of the methods above like: 0012345~0012360, 9876544",
    "5. Numbers of length less than 7 will be padded with 0 in the beginning.",
  ];

  @override
  void initState() {
    super.initState();
    _controller  = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 90.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getHeader(),
            SizedBox(height: 8.0),
            _getRules(),
            SizedBox(height: 20.0),
            _getInputBox(),
            SizedBox(height: 16.0),
            _getSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Text(
      ADD_PRIZEBOND_RULES,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
        fontSize: 18.0,
      ),
    );
  }

  Widget _getRules() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _rules.length,
      itemBuilder: (context, index) {
        return Text(_rules[index]);
      },
    );
  }

  Widget _getInputBox() {
    return TextField(
      decoration: InputDecoration(
        hintText: ADD_PRIZEBOND_HINT,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9,~ ]')),
      ],
    );
  }

  Widget _getSubmitButton() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 24.0),
      color: Colors.deepPurple,
      child: Text(
        BUTTON_ADD_PRIZEBOND,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: () => _processAndInsertIntoDB(),
    );
  }

  void _processAndInsertIntoDB() {
    List<String> _prizeBondNumbers = [];
    String _text = _controller.text.replaceAll(" ", "");
    List<String> _texts = _text.split(",");
    _error.clear();

    for (String text in _texts) {
      _prizeBondNumbers.addAll(_processNumber(text));
    }

    _prizeBondNumbers = _prizeBondNumbers.toSet().toList();
    _insertIntoDb(_prizeBondNumbers);
    _controller.text = "";
  }

  void _insertIntoDb(List<String> prizeBondNumbers) async {
    List<PrizeBond> _allBonds = [];
    for (String number in prizeBondNumbers) {
      _allBonds.add(PrizeBond(prizeBondNumber: number));
    }
    widget.prizeBondManagerBloc.add(InsertDataEvent(_allBonds, _error));
  }

  List<String> _processNumber(String numberText) {
    List<String> _formattedNumbers = [];
    
    if (numberText.contains("~")) {
      List<String> _allNum = numberText.split("~");

      if (_allNum.length == 2) {
        int _numStart = int.tryParse(_allNum[0]);
        int _numEnd = int.tryParse(_allNum[1]);

        if (_numStart < _numEnd) {
          for (int i=_numStart; i<=_numEnd; i++) {
            String _n = i.toString().padLeft(7, '0');
            if (_n.length != 7) _error.add(_n);
            else _formattedNumbers.add(_n);
          }
        } else {
          _error.add(numberText);
        }
      } else {
        _error.add(numberText);
      }

    } else {
      String _n = numberText.padLeft(7, '0');
      if (_n.length != 7) _error.add(_n);
      else _formattedNumbers.add(_n);
    }

    return _formattedNumbers;
  }
}
