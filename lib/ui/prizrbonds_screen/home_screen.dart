import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/data_store/data_store.dart';

import 'prizebond_bloc/prizebond_bloc.dart';
import 'prizebond_bloc/prizebond_state.dart';
import 'add_prizebonds_screen.dart';
import 'all_prizebonds_screen.dart';
import 'check_draw_result_screen.dart';

class HomeScreen extends StatefulWidget {
  final int selectedIndex;

  const HomeScreen({Key key, this.selectedIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _screenTitles = [ADD_PRIZEBONDS, ALL_PRIZEBONDS, CHECK_PRIZEBONDS_DRAW];
  final List<Widget> _screens = [AddPrizeBondsScreen(), AllPrizeBondsScreen(), CheckPrizeBondDrawScreen()];
  PrizeBondManagerBloc _prizeBondManagerBloc;
  StreamSubscription _prizeBondListener;
  DataStore _dataStore;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _prizeBondManagerBloc = PrizeBondManagerBloc();
    _selectedIndex = widget.selectedIndex;
    _dataStore = RepositoryProvider.of<DataStore>(context);
    _listenToBloc();
  }

  @override
  void dispose() {
    _prizeBondListener?.cancel();
    _prizeBondManagerBloc?.close();
    super.dispose();
  }

  void _listenToBloc() {
    _prizeBondListener = _prizeBondManagerBloc.listen((state) {
      if (state is AllDataFetchSuccessState) {
        _dataStore.allPrizeBonds = state.allPrizeBonds;
      } else if (state is AllDataFetchFailureState) {
        print("Could not fetch data.");
      } else if (state is InsertDataSuccessState) {
        _dataStore.allPrizeBonds = state.allPrizeBonds;
        print("Inserted ids: ${state.ids}");
        // TODO: Show success dialog
      } else if (state is InsertingDataState || state is FetchingAllDataState) {
        print("Doing some work.");
        // TODO: Show progress dialog
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenTitles[_selectedIndex]),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 16, left: 12),
            icon: Icon(Icons.backup),
            tooltip: BACKUP_DATABASE,
            onPressed: () {
              // TODO: Implement backup logic
            },
          ),
        ],
      ),
      body: _getScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToScreen(0),
        tooltip: BUTTON_ADD_PRIZEBOND,
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.add, title: ADD_PRIZEBONDS),
          TabItem(icon: Icons.home, title: ALL_PRIZEBONDS),
          TabItem(icon: Icons.money, title: CHECK_PRIZEBONDS_DRAW),
        ],
        backgroundColor: Colors.deepPurple,
        style: TabStyle.reactCircle,
        initialActiveIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void _navigateToScreen(int index) {
    if (index != _selectedIndex) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(selectedIndex: index)
      ));
    }
  }

  Widget _getScreen() {
    if (_selectedIndex == 0) {
      return AddPrizeBondsScreen(prizeBondManagerBloc: _prizeBondManagerBloc);
    } else if (_selectedIndex == 1) {
      return AllPrizeBondsScreen(allPrizeBonds: _dataStore.allPrizeBonds);
    }
    return _screens[_selectedIndex];
  }
}
