/*
[
  {
    "otherUserId": "saso",
    "lastMessage": "hello sir",
    "lastMessageTime": "2025-03-21T12:19:15.95"
  }
]
 */

import 'package:untitled3/features/home/domain/entity/ConversationEntity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({required super.otherUserId, required super.lastMessage, required super.lastMessageTime});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      otherUserId: json['otherUserId'] as String? ?? "",
      lastMessage: json['lastMessage'] as String? ?? "",
      lastMessageTime: DateTime.parse(json['lastMessageTime'] as String? ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'otherUserId': otherUserId,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
    };
  }

}