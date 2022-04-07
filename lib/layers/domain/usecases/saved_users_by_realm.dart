import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

import '../../../common/errors/failure.dart';
import '../repositories/repository.dart';

class GetSavedUsersByRealm {
  final Repository repository;

  GetSavedUsersByRealm({required this.repository});

  Future<Either<Failure, List<User>>> execute(String realm) async {
    return repository.getSavedUsersByRealm(realm);
  }
}
