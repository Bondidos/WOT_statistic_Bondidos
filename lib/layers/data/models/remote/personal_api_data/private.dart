import 'Restrictions.dart';

class Private {
  Map<String, dynamic> privateData;

  Private({required this.privateData});

  factory Private.fromJson(Map<String, dynamic> json) {
    return Private(
      privateData: <String, dynamic>{
        'Ban Info': json['ban_info'],
        'Ban Time': json['ban_time'],
        'Battle Life Time': json['battle_life_time'],
        'Bonds': json['bonds'],
        'Credits': json['credits'],
        'Free Xp': json['free_xp'],
        'Gold': json['gold'],
        'Bounded to phone': json['is_bound_to_phone'],
        'Premium': json['is_premium'],
        'Premium expires': json['premium_expires_at'],
        'Restrictions': Restrictions.fromJson(json['restrictions']),
      },
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['battle_life_time'] = privateData['Battle Life Time'];
    data['bonds'] = privateData['Bonds'];
    data['credits'] = privateData['Credits'];
    data['free_xp'] = privateData['Free Xp'];
    data['gold'] = privateData['Gold'];
    data['is_bound_to_phone'] = privateData['Bounded to phone'];
    data['is_premium'] = privateData['Premium'];
    data['premium_expires_at'] = privateData['Premium expires'];
    data['ban_info'] = privateData['Ban Info'];
    data['ban_time'] = privateData['Ban Time'];
    data['restrictions'] = privateData['Restrictions'].toJson();
    return data;
  }
}
