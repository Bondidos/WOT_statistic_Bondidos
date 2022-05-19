import 'package:wot_statistic/layers/data/sources/settings/user_settings.dart';

class ApiConstants {
  final UserSettings userSettings;

  const ApiConstants({required this.userSettings});

  static const searchUsersLimit = 10;
  static const applicationId = '5d489c586717c2b76ade8bea16607167';

  static const tankIdFieldQueryParameter = 'tank_id';
  static const isPremiumFieldQueryParameter = "is_premium";
  static const imagesFieldQueryParameter = "images";
  static const typeFieldQueryParameter = "type";
  static const descriptionFieldQueryParameter = "description";
  static const nameFieldQueryParameter = "name";
  static const isGiftFieldQueryParameter = "is_gift";
  static const nationFieldQueryParameter = "nation";
  static const tierFieldQueryParameter = "tier";

  static const privateQueryParameter = "private";
  static const globalRatingQueryParameter = "global_rating";
  static const clanIdQueryParameter = "clan_id";
  static const nicknameQueryParameter = "nickname";
  static const logoutAtQueryParameter = "logout_at";

  int get userId => userSettings.signedUser.id;

  String get accessToken => userSettings.signedUser.accessToken;

  int get userNoPrivateId => userSettings.userNoPrivateData.userId;

  bool get isPrivateAllowed => userSettings.isPrivateDataAllowed;

  Map<String, dynamic> createPersonalDataQuery() => {
        'application_id': applicationId,
        'account_id': userId,
        'access_token': accessToken,
        'fields': [
          privateQueryParameter,
          globalRatingQueryParameter,
          clanIdQueryParameter,
          nicknameQueryParameter,
          logoutAtQueryParameter,
        ].unpack(),
      };

  Map<String, dynamic> createClanInfoQuery({required int clanId}) => {
        'application_id': applicationId,
        'clan_id': clanId,
      };

  Map<String, dynamic> createUserVehiclesQuery() => {
        'application_id': applicationId,
        'account_id': isPrivateAllowed ? userId : userNoPrivateId,
        'access_token': isPrivateAllowed ? accessToken : null,
      };

  Map<String, dynamic> createVehiclesDatabaseQuery({
    required int limit,
    required int pageNumber,
    required String language,
  }) =>
      {
        'application_id': applicationId,
        'limit': limit,
        'page_no': pageNumber,
        'language': language,
        'fields': [
          tankIdFieldQueryParameter,
          isPremiumFieldQueryParameter,
          imagesFieldQueryParameter,
          typeFieldQueryParameter,
          descriptionFieldQueryParameter,
          nameFieldQueryParameter,
          isGiftFieldQueryParameter,
          nationFieldQueryParameter,
          tierFieldQueryParameter,
        ].unpack(),
      };

  Map<String, dynamic> createAchievesDataQuery() => {
        'application_id': applicationId,
        'account_id': isPrivateAllowed ? userId : userNoPrivateId,
      };

  Map<String, dynamic> createAchievesDatabaseQuery({required language}) => {
        'application_id': applicationId,
        'language': language,
      };

  Map<String, dynamic> createSearchUserQuery({required search}) => {
        'application_id': applicationId,
        'search': search,
        'limit': searchUsersLimit,
      };

  Map<String, dynamic> createTokenExtensionQuery() => {
        'application_id': applicationId,
      };

  Map<String, dynamic> createUserNoPrivateQuery() => {
    'application_id': applicationId,
    'account_id' : userNoPrivateId,
    "fields": [
      nicknameQueryParameter,
      clanIdQueryParameter,
      globalRatingQueryParameter
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
