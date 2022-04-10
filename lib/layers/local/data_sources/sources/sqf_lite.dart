import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../common/constants/constants.dart';

class DatabaseHelper {
  static const _dataBaseName = "WotStatDatabase.db";
  static const _dataBaseVersion = 1;

  // EU realm
  static const euTable = "eu_table";

  // CIS realm
  static const cisTable = "cis_table";

  // common columns
  static const columnId = "id";
  static const nickname = "nickname";
  static const accessToken = "accessToken";
  static const expiresAt = "expiresAt";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _dataBaseName);
    return openDatabase(path, version: _dataBaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE $euTable(
      $columnId INTEGER PRIMARY KEY,
      $nickname TEXT NOT NULL,
      $accessToken TEXT NOT NULL,
      $expiresAt INTEGER NOT NULL
      )
      """);
    await db.execute("""
      CREATE TABLE $cisTable(
      $columnId INTEGER PRIMARY KEY,
      $nickname TEXT NOT NULL,
      $accessToken TEXT NOT NULL,
      $expiresAt INTEGER NOT NULL
      )
      """);
  }

  Future<int> insertUserByRealm(Map<String, dynamic> user, String realm) async {
    Database? db = await instance.database;
    if (realm == EU && db != null) {
      return db.insert(euTable, user,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    if (realm == CIS && db != null) {
      return db.insert(cisTable, user,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return 0;
  }

  Future<List<Map<String, dynamic>>> getSavedUsersByRealm(String realm) async {
    Database? db = await instance.database;
    if (realm == EU && db != null) {
      return db.query(euTable);
    }
    if (realm == CIS && db != null) {
      return db.query(cisTable);
    }
    return [];
  }

  Future<int> removeUserByRealm(Map<String, dynamic> user, String realm) async {
    Database? db = await instance.database;
    if (realm == EU && db != null) {
      return db.delete(
        euTable,
        where: '$columnId = ${user[columnId]}',
      );
    }
    if (realm == CIS && db != null) {
      return db.delete(
        cisTable,
        where: '$columnId = ${user[columnId]}',
      );
    }
    return 0;
  }
}
