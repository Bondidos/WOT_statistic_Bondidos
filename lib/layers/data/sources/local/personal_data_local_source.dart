import 'package:wot_statistic/layers/data/models/local/user_data.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';

abstract class PersonalDataLocalSource {
  UserData get signedUser;

  void saveUser(User user);

  Future<void> setSignedUser(User user);
}
