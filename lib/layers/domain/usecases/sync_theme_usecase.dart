
import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/errors/failure.dart';

class SyncThemeUseCase {
  final Repository repository;
  SyncThemeUseCase({required this.repository});

  Future<Either<Failure,String>> execute([String? pref]) async {
    return repository.syncThemeWithCache(pref);
  }
}