import 'package:drift/web.dart';

import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database/database.dart';

Database constructDb({bool logStatements = false}) {
  return Database(WebDatabase('db', logStatements: logStatements));
}
