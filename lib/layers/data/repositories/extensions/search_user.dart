import 'package:wot_statistic/layers/data/models/local/user_no_private_data.dart';
import 'package:wot_statistic/layers/data/models/remote/search_user/search_user_account_data_api.dart';
import 'package:wot_statistic/layers/domain/entities/user_no_private.dart';

extension SearchUserAccountDataApiExtensions on SearchUserAccountDataApi {
  UserNoPrivate createFoundUserFromSearchUserData() =>
      UserNoPrivate(name: nickname, id: accountId);
}

extension UserNoPrivateExtensions on UserNoPrivate {
  UserNoPrivateData toUserNoPrivateData() => UserNoPrivateData(
        nickname: name,
        userId: id,
      );
}
