import 'package:wot_statistic/layers/data/sources/local/sign_local_datasource.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/sign_in_repo.dart';

class SignInRepoImpl implements SignInRepo {
  final SignLocalDataSource signLocalSource;

  SignInRepoImpl({
    required this.signLocalSource,
  });

  @override
  Future<void> removeUser(User user) => signLocalSource.removeUser(user);

  @override
  void saveUser(User user) => signLocalSource.saveUser(user);

  @override
  void setRealm(String realm) => signLocalSource.setRealm(realm);

  @override
  Future<void> setSingedUser(User user) async {
    signLocalSource.setSignedUser(user);
  }

  @override
  Stream<String> get subscribeRealm => signLocalSource.subscribeRealm();

  @override
  Stream<List<User>> get subscribeUsers => signLocalSource.subscribeUsers();

  @override
  void signOut() => signLocalSource.signOut();
}
