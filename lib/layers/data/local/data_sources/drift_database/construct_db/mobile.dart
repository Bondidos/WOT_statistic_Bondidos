import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';

import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;

import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database/database.dart';

WotStatDatabase constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      final dbFile = File(p.join(dataDir.path, 'db.sqlite'));
      return NativeDatabase(dbFile, logStatements: logStatements);
    });
    return WotStatDatabase(executor);
  }
  if (Platform.isMacOS || Platform.isLinux) {
    final file = File('db.sqlite');
    return WotStatDatabase(NativeDatabase(file, logStatements: logStatements));
  }
  //todo windows
  // if (Platform.isWindows) {
  //   final file = File('db.sqlite');
  //   return Database(NativeDatabase(file, logStatements: logStatements));
  // }
  return WotStatDatabase(NativeDatabase.memory(logStatements: logStatements));
}
