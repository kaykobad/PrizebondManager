import 'package:flutter/material.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';

class AllPrizeBondsScreen extends StatefulWidget {
  final Function(int) setSelectedIndex;
  final List<PrizeBond> allPrizeBonds;

  const AllPrizeBondsScreen({Key key,
    this.setSelectedIndex,
    this.allPrizeBonds,
  }) : super(key: key);

  @override
  _AllPrizeBondsScreenState createState() => _AllPrizeBondsScreenState();
}

class _AllPrizeBondsScreenState extends State<AllPrizeBondsScreen> {
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

    return Text("All prizebonds page");
  }
}
