/*
[
  {
    "otherUserId": "saso",
    "lastMessage": "hello sir",
    "lastMessageTime": "2025-03-21T12:19:15.95"
  }
]
 */

class ConversationEntity{
  final String otherUserId;
  final String lastMessage;
  final DateTime lastMessageTime;


  ConversationEntity({required this.otherUserId, required this.lastMessage, required this.lastMessageTime});

}