import 'package:drift/web.dart';

import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database/database.dart';

WotStatDatabase constructDb({bool logStatements = false}) {
  return WotStatDatabase(WebDatabase('db', logStatements: logStatements));
}
