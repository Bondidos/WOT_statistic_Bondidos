import 'package:drift/drift.dart';
import '../wot_stat_database.dart';

part 'wot_stat_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class WotStatDao extends DatabaseAccessor<WotStatDatabase> with _$WotStatDaoMixin {
  final WotStatDatabase wotStatDatabase;
  WotStatDao( this.wotStatDatabase) : super(wotStatDatabase);

}