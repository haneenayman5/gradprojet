import 'dart:async';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/chat/data/models/message.dart';

class ChatService {
  late HubConnection _hubConnection;
  final SecureStorage secureStorage;

  ChatService({required this.secureStorage}) {
  }

  Future<void> connect() async {
    String? username = await secureStorage.getUsername();
    String? token = await secureStorage.getToken();
    String url = '$chatBaseURL/ChatHub?userId=$username&access_token=$token';
    print(url);
    _hubConnection = HubConnectionBuilder()
        .withUrl(url,  options: HttpConnectionOptions(
      transport: HttpTransportType.LongPolling,
    ))
        .build();
    try {
      await _hubConnection.start();
      print("Connected to SignalR");
    } catch (e) {
      print("Error connecting to SignalR: $e");
    }


    //add listeners
  }

  void sendMessage(ChatMessageModel message) {
    _hubConnection.invoke('SendMessage', args: [message.sender, message.receiver, message.message]);
  }

  void onMessageReceived(Function(ChatMessageModel) callback) {
    _hubConnection.on('ReceiveMessage', (arguments) {
      String sender = arguments![0] as String;
      String receiver = arguments[1] as String;
      String message = arguments[2] as String;
      final ChatMessageModel messageModel = ChatMessageModel(sender: sender, receiver: receiver, message: message, time: DateTime.now());
      callback(messageModel);
    });
  }

  Future<List<ChatMessageModel>> loadMessages(String senderId, String receiverId) async {
    // Ensure connection is established before invoking the method.
    await connect();

    // Create a completer that will complete when the messages are received.
    final completer = Completer<List<ChatMessageModel>>();

    // Set up a listener for the "LoadMessages" event.
    _hubConnection.on('LoadMessages', (arguments) {
      // Assuming the server sends back a list as the first argument.
      if (arguments != null && arguments.isNotEmpty) {
        final messagesList = arguments[0] as List;
        final messages = messagesList
            .map((json) => ChatMessageModel.fromJson(json))
            .toList();
        completer.complete(messages);
      } else {
        completer.completeError("No messages received");
      }
    });

    try {
      // Invoke the "LoadMessages" method on the hub.
      await _hubConnection.invoke("LoadMessages", args: [senderId, receiverId]);
    } catch (e) {
      // In case of an error, complete the completer with an error.
      if (!completer.isCompleted) {
        completer.completeError("Error loading messages: $e");
      }
    }

    // Return the Future that completes when messages are received.
    return completer.future;
  }


  Future<void> disconnect() async {
    await _hubConnection.stop();
  }
}
