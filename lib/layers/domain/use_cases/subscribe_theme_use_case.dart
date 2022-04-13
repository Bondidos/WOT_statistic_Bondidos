import 'package:dartz/dartz.dart';
import 'package:wot_statistic/layers/domain/repositories/repository.dart';

import '../../../common/errors/failure.dart';

class SubscribeThemeUseCase {
  final Repository repository;

  SubscribeThemeUseCase({required this.repository});

  Stream<String> execute() => repository.subscribeTheme;
}
