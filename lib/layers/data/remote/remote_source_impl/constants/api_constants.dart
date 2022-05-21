import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';
import 'api_query_constants.dart' as field;
import 'api_query_keys_constants.dart' as key;

class ApiConstants {
  final UserSettings userSettings;

  const ApiConstants({required this.userSettings});

  int get userId => userSettings.signedUser.id;

  String get accessToken => userSettings.signedUser.accessToken;

  int get userNoPrivateId => userSettings.userNoPrivateData.userId;

  bool get isPrivateAllowed => userSettings.isPrivateDataAllowed;

  Map<String, dynamic> createPersonalDataQuery() => {
        key.applicationId: field.applicationId,
        key.accountId: userId,
        key.accessToken: accessToken,
        key.fields: [
          field.privateQueryParameter,
          field.globalRatingQueryParameter,
          field.clanIdQueryParameter,
          field.nicknameQueryParameter,
          field.logoutAtQueryParameter,
        ].unpack(),
      };

  Map<String, dynamic> createClanInfoQuery({required int clanId}) => {
        key.applicationId: field.applicationId,
        key.clanId: clanId,
      };

  Map<String, dynamic> createUserVehiclesQuery() => {
        key.applicationId: field.applicationId,
        key.accountId: isPrivateAllowed ? userId : userNoPrivateId,
        key.accessToken: isPrivateAllowed ? accessToken : null,
      };

  Map<String, dynamic> createVehiclesDatabaseQuery({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      {
        key.applicationId: field.applicationId,
        key.limit: limit,
        key.pageNo: pageNumber,
        key.language: language,
        key.fields: [
          field.tankIdFieldQueryParameter,
          field.isPremiumFieldQueryParameter,
          field.imagesFieldQueryParameter,
          field.typeFieldQueryParameter,
          field.descriptionFieldQueryParameter,
          field.nameFieldQueryParameter,
          field.isGiftFieldQueryParameter,
          field.nationFieldQueryParameter,
          field.tierFieldQueryParameter,
        ].unpack(),
      };

  Map<String, dynamic> createAchievesDataQuery() => {
        key.applicationId: field.applicationId,
        key.accountId: isPrivateAllowed ? userId : userNoPrivateId,
      };

  Map<String, dynamic> createAchievesDatabaseQuery({required language}) => {
        key.applicationId: field.applicationId,
        key.language: language,
      };

  Map<String, dynamic> createSearchUserQuery({required search}) => {
        key.applicationId: field.applicationId,
        key.search: search,
        key.limit: field.searchUsersLimit,
      };

  Map<String, dynamic> createTokenExtensionQuery() => {
        key.applicationId: field.applicationId,
      };

  Map<String, dynamic> createUserNoPrivateQuery() => {
        key.applicationId: field.applicationId,
        key.accountId: userNoPrivateId,
        key.fields: [
          field.nicknameQueryParameter,
          field.clanIdQueryParameter,
          field.globalRatingQueryParameter,
          field.logoutAtQueryParameter,
        ].unpack(),
      };
}

extension UnpackList on List<String> {
  String unpack() {
    StringBuffer fields = StringBuffer();
    forEach((element) {
      fields.write(element + ',');
    });
    return fields.toString();
  }
}
