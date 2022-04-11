import 'package:drift/drift.dart';
import '../wot_stat_database.dart';

part 'database.g.dart';

@DriftDatabase(
    tables: [UserTable],
    daos: [WotStatDao]
)
class WotStatDatabase extends _$WotStatDatabase{

  WotStatDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
