import 'package:drift/web.dart';

import '../database/database.dart';

WotStatDatabase constructDb({bool logStatements = false}) {
  return WotStatDatabase(WebDatabase('db', logStatements: logStatements));
}
