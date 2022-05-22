import 'package:wot_statistic/layers/data/local/data_sources/drift_database/database.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

extension UserTableDataConverting on UserTableData {
  User toUser() => User(
        id: id,
        nickname: nickname,
        accessToken: token,
        expiresAt: expiresAt,
      );
}
