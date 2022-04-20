
import 'package:json_annotation/json_annotation.dart';

class Restrictions {
    @JsonKey(name: 'chat_ban_time')
    String? chatBanTime;

    Restrictions({required this.chatBanTime});

    factory Restrictions.fromJson(Map<String, dynamic> json) {
        return Restrictions(
            chatBanTime: json['chat_ban_time']
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if (chatBanTime != null) {
            data['chat_ban_time'] = chatBanTime;
        }
        return data;
    }
}