import 'package:dio/dio.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/data/sources/local/sign_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

const eu = "EU";
const cis = "CIS";
const baseUrlEu = 'https://api.worldoftanks.eu';
const baseUrlCis = 'https://api.worldoftanks.ru';

class SignInRepoImpl implements SignInRepo {
  final SignLocalDataSource signLocalSource;
  final RemoteDataSource remoteSource;
  final BaseOptions baseOptions;

  SignInRepoImpl({
    required this.signLocalSource,
    required this.remoteSource,
    required this.baseOptions,
  }) {
      baseOptions.baseUrl =
          signLocalSource.getCurrentRealm() == cis ? baseUrlCis : baseUrlEu;
  }

  @override
  Future<void> removeUser(User user) => signLocalSource.removeUser(
      UserData.fromUserAndRealm(user, signLocalSource.getCurrentRealm()));

  @override
  void saveUser(User user, String realm) =>
      signLocalSource.saveUser(UserData.fromUserAndRealm(user, realm));

  @override
  void setRealm(String realm) {
    signLocalSource.setRealm(realm);
    baseOptions.baseUrl = (realm == eu) ? baseUrlEu : baseUrlCis;
  }

  @override
  Future<void> setSingedUser(User user) => signLocalSource.setSingedUser(
      UserData.fromUserAndRealm(user, signLocalSource.getCurrentRealm()));

  @override
  Stream<String> get subscribeRealm => signLocalSource.subscribeRealm();

  @override
  Stream<List<User>> get subscribeUsers => signLocalSource.subscribeUsers();
}
