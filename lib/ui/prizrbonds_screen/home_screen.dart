import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prizebond_manager/constants/string_constants.dart';
import 'package:prizebond_manager/data/data_store/data_store.dart';
import 'package:prizebond_manager/ui/prizrbonds_screen/add_prizebonds_screen.dart';
import 'package:prizebond_manager/ui/prizrbonds_screen/all_prizebonds_screen.dart';
import 'package:prizebond_manager/ui/prizrbonds_screen/check_draw_result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _screenTitles = [ADD_PRIZEBONDS, ALL_PRIZEBONDS, CHECK_PRIZEBONDS_DRAW];
  final List<Widget> _screens = [AddPrizeBondsScreen(), AllPrizeBondsScreen(), CheckPrizeBondDrawScreen()];
  DataStore _dataStore;
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
    _dataStore = RepositoryProvider.of<DataStore>(context);
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
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

  Widget _getScreen() {
    if (_selectedIndex == 1) {
      return AllPrizeBondsScreen(
        setSelectedIndex: _setSelectedIndex,
        allPrizeBonds: _dataStore.allPrizeBonds,
      );
    }
    return _screens[_selectedIndex];
  }
}
