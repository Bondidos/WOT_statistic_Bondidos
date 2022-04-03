import 'package:dartz/dartz.dart';

import '../../../common/errors/failure.dart';

abstract class Repository {
  Future<Either<Failure,String>> syncThemeWithCache(String? pref);
}