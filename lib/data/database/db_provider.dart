import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prizebond_manager/data/models/prizebond.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "prizeBondManager.db");
    return await openDatabase(path, version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE PrizeBond ("
            "id INTEGER PRIMARY KEY,"
            "prizeBondNumber TEXT,"
            "insertDate TEXT,"
            "updateDate TEXT"
            ")"
        );
      },
    );
  }

  Future<int> insertPrizeBond(PrizeBond prizeBond) async {
    final db = await database;
    var data = await db.query("PrizeBond", where: "prizeBondNumber = ?", whereArgs: [prizeBond.prizeBondNumber]);
    if (data.isEmpty) {
      prizeBond.insertDate = DateTime.now().toString();
      prizeBond.updateDate = "";
      return await db.insert("PrizeBond", prizeBond.toMap());
    }
    return Future.value(-1);
  }

  Future<List<int>> insertAllPrizeBonds(List<PrizeBond> prizeBonds) async {
    List<int> ids = [];
    for (PrizeBond prizeBond in prizeBonds) {
      ids.add(await insertPrizeBond(prizeBond));
    }
    return ids;
  }

  Future<int> updatePrizeBond(PrizeBond prizeBond) async {
    final db = await database;
    prizeBond.updateDate = DateTime.now().toString();
    return await db.update("PrizeBond", prizeBond.toMap(), where: "id = ?", whereArgs: [prizeBond.id]);
  }

  Future<int> deletePrizeBondById(int id) async {
    final db = await database;
    return await db.delete("PrizeBond", where: "id = ?", whereArgs: [id]);
  }

  Future<List<PrizeBond>> getAllPrizeBonds() async {
    final db = await database;
    var res = await db.query("PrizeBond");
    List<PrizeBond> list = res.isNotEmpty ? res.map((c) => PrizeBond.fromMap(c)).toList() : [];
    return list;
  }
}