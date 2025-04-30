/*
[
  {
    "otherUserId": "saso",
    "lastMessage": "hello sir",
    "lastMessageTime": "2025-03-21T12:19:15.95",
    "otherUserPfpUrl": "http://localhost:5162/avatars/s.jpg"
  }
]
 */

class ConversationEntity{
  final String otherUserId;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String otherUserPfpUrl;


  ConversationEntity({required this.otherUserId, required this.lastMessage, required this.lastMessageTime, required this.otherUserPfpUrl});

}