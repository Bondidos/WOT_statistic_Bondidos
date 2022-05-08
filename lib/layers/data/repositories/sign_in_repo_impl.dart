import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/data/sources/remote_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

const eu = "EU";
const cis = "CIS";
const baseUrlEu = 'https://api.worldoftanks.eu';
const baseUrlCis = 'https://api.worldoftanks.ru';

class SignInRepoImpl implements SignInRepo {
  final LocalDataSource localSource;
  final RemoteDataSource remoteSource;
  final Logger logger = Logger();
  final BaseOptions baseOptions;

  SignInRepoImpl({
    required this.localSource,
    required this.remoteSource,
    required this.baseOptions,
  }) {
    {
      baseOptions.baseUrl =
          localSource.getCurrentRealm() == cis ? baseUrlCis : baseUrlEu;
    }
  }

  @override
  Future<void> removeUser(User user) => localSource.removeUser(
      UserData.fromUserAndRealm(user, localSource.getCurrentRealm()));

  @override
  void saveUser(User user, String realm) =>
      localSource.saveUser(UserData.fromUserAndRealm(user, realm));

  @override
  void setRealm(String realm) {
    localSource.setRealm(realm);
    baseOptions.baseUrl = (realm == eu) ? baseUrlEu : baseUrlCis;
  }

  @override
  Future<void> setSingedUser(User user) => localSource.setSingedUser(
      UserData.fromUserAndRealm(user, localSource.getCurrentRealm()));

  @override
  Stream<String> get subscribeRealm => localSource.subscribeRealm();

  @override
  Stream<List<User>> get subscribeUsers => localSource.subscribeUsers();
}
