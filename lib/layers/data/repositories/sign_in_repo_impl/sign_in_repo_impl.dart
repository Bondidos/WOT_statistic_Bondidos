import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/data/sources/remote/remote_data_source.dart';
import 'package:wot_statistic/layers/data/sources/local/sign_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SignInRepoImpl implements SignInRepo {
  final SignLocalDataSource signLocalSource;
  final RemoteDataSource remoteSource;

  SignInRepoImpl({
    required this.signLocalSource,
    required this.remoteSource,
  }) ;
  @override
  Future<void> removeUser(User user) => signLocalSource.removeUser(
      UserData.fromUserAndRealm(user, signLocalSource.currentRealm));

  @override
  void saveUser(User user, String realm) =>
      signLocalSource.saveUser(UserData.fromUserAndRealm(user, realm));

  @override
  void setRealm(String realm) => signLocalSource.setRealm(realm);

  @override
  Future<void> setSingedUser(User user) async {
    signLocalSource.setSignedUser(
      UserData.fromUserAndRealm(
        user,
        signLocalSource.currentRealm,
      ),
    );
  }

  @override
  Stream<String> get subscribeRealm => signLocalSource.subscribeRealm();

  @override
  Stream<List<User>> get subscribeUsers => signLocalSource.subscribeUsers();
}
