import 'package:dartz/dartz.dart';
import 'package:wot_statistic/common/errors/failure.dart';
import 'package:wot_statistic/layers/data/sources/local_data_source.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

class RepositoryImpl extends Repository {
  final LocalDataSource localSource;

  RepositoryImpl({required this.localSource});

  @override
  Future<Either<Failure, String>> syncThemeWithCache(String? pref) async {
    return (pref != null)
        ? _setThemePref(pref)
        : _getThemePref();
  }

  Future<Either<Failure, String>> _getThemePref() async {
    try{
      final String? pref = await localSource.getThemePreference();
      return (pref != null)
          ? Right(pref)
          : const Left(Failure());
    } catch (e) {
      return const Left(Failure());
    }
  }

  Future<Either<Failure, String>> _setThemePref(String pref) async {
    try {
      await localSource.saveThemePreference(pref);
      return Right(pref);
    } catch (e){
      return const Left(Failure());
    }
  }

  @override
  Future<bool> saveUser(User user) async {
    try{
      await localSource.saveUser(user);
      return true;
    } catch(e){
      return false;
    }
  }

  @override
  Future<Either<Failure, List<User>>> getSavedUsersByRealm(String realm) async{
    try{
      List<User> userList = await localSource.getSavedUsersByRealm(realm);
      return Right(userList);
    } catch (e){
      return const Left(Failure("Can't find Users"));
    }
  }
}
