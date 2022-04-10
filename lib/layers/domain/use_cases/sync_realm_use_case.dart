import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';
import '../repositories/repository.dart';

class SyncRealmUseCase {
  final Repository repository;

  SyncRealmUseCase({required this.repository});

  Future<Either<Failure, String>> execute() async {
    return repository.syncRealmPreference();
  }
}
