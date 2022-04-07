import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/repository.dart';

class SaveUserUseCase {
  final Repository repository;
  SaveUserUseCase({required this.repository});

  Future<Either<Failure, int>> execute(User user,String realm) async {
    return repository.saveUser(user,realm);
  }
}