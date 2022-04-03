
import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/errors/failure.dart';

class SyncThemeUseCase {
  final Repository repository;
  SyncThemeUseCase({required this.repository});

  //todo ask native platform which theme (light/dark) is current

  Future<Either<Failure,String>> execute([String? pref]) async {
    return repository.syncThemeWithCache(pref);
  }
}