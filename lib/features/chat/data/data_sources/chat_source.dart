import 'dart:async';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/storage/storage.dart';
import 'package:untitled3/features/chat/data/models/message.dart';
import 'package:logging/logging.dart';

class ChatService {
  late HubConnection _hubConnection;
  final SecureStorage secureStorage;
  bool _isConnecting = false;

  ChatService({required this.secureStorage});

  Future<void> connect() async {
    if (_isConnecting) {
      print("Connection is already in progress or connected.");
      return; // Prevent multiple attempts
    }

    _isConnecting = true; // Set flag
    print("Setting _isConnecting to true"); // Log for debugging

    String? username = await secureStorage.getUsername();
    String? token = await secureStorage.getToken();
    String url = '$chatBaseURL/ChatHub?userId=$username&access_token=$token';
    print(url);

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });

    final hubProtLogger = Logger("SignalR - hub");

    _hubConnection = HubConnectionBuilder()
        .withUrl(url, options: HttpConnectionOptions(
        transport: HttpTransportType.LongPolling,
        requestTimeout: 2000 // Still the poll request timeout
    )).configureLogging(hubProtLogger)
        .build();

    int retryCount = 0;
    const int maxRetries = 5;

    while (_hubConnection.state != HubConnectionState.Connected && retryCount < maxRetries) {
      retryCount++;
      print("Attempting to reconnect (Attempt $retryCount of $maxRetries)...");
      try {
        await _hubConnection.start()?.timeout(const Duration(seconds: 5), onTimeout: () async {
          print("Start Future timed out during retry.");
          _hubConnection = HubConnectionBuilder()
              .withUrl(url, options: HttpConnectionOptions(
              transport: HttpTransportType.LongPolling,
              requestTimeout: 2000
          )).configureLogging(hubProtLogger)
              .build();
          throw TimeoutException('Connection start timed out during retry');
        });
        print("Connected to SignalR after retry!");
        _isConnecting = false;
        print("Setting _isConnecting to false");
      } catch (e) {
        print("Error connecting to SignalR during retry: $e");
      }

      if (_hubConnection.state != HubConnectionState.Connected && retryCount < maxRetries) {
        int delayMilliseconds = 500 * retryCount;
        // Optionally: await Future.delayed(Duration(milliseconds: delayMilliseconds));
      } else if (_hubConnection.state != HubConnectionState.Connected && retryCount >= maxRetries) {
        print("Max retry attempts reached. Connection failed.");
        _isConnecting = false;
        print("Setting _isConnecting to false");
      }
    }
    print("Exited connection loop. Final Connection state: ${_hubConnection.state}");
    if (_hubConnection.state != HubConnectionState.Connected) {
      print("Failed to connect to SignalR after multiple retries.");
    }
  }

  Future<void> sendMessage(ChatMessageModel message) async {
    await _hubConnection.invoke('SendMessage', args: [message.sender, message.receiver, message.message]);
  }

  void onMessageReceived(void Function(ChatMessageModel) callback) {
    _hubConnection.on('ReceiveMessage', (List<Object?>? args) {
      if (args == null || args.length < 4) throw Exception("Message received with wrong formatting");

      final sender = args[0] as String;
      final receiver = args[1] as String;
      final content = args[2] as String;
      final rawTime = args[3] as String;
      final time = DateTime.parse(rawTime).toLocal();

      callback(ChatMessageModel(
        sender: sender,
        receiver: receiver,
        message: content,
        time: time,
      ));
    });
  }

  Future<List<ChatMessageModel>> loadMessages(String senderId, String receiverId) async {
    await connect();

    final completer = Completer<List<ChatMessageModel>>();

    _hubConnection.on('LoadMessages', (arguments) {
      if (arguments != null && arguments.isNotEmpty) {
        final messagesList = arguments[0] as List;
        final messages = messagesList.map((json) => ChatMessageModel.fromJson(json)).toList();
        completer.complete(messages);
      } else {
        completer.completeError("No messages received");
      }
    });

    try {
      await _hubConnection.invoke("LoadMessages", args: [senderId, receiverId]);
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError("Error loading messages: $e");
      }
    }

    return completer.future;
  }

  Future<void> disconnect() async {
    await _hubConnection.stop();
  }
}
