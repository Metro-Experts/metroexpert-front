import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';

class ChatbotPageController extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String threadId = '';
  List<ChatMessage> messages = <ChatMessage>[];
  List<ChatUser> typingUsers = <ChatUser>[];

  ChatUser get gptChatUser {
    return ChatUser(
      id: '1',
      firstName: 'Chat',
      lastName: 'GPT',
    );
  }

  ChatUser get currentUser {
    return ChatUser(
      id: Auth().currentUser!.uid,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future<void> fetchThread(BuildContext context) async {
    var uri = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/assistant/thread');
    final threadIdRequest = await http.get(uri);
    final threadIdRequestObject = jsonDecode(threadIdRequest.body);
    threadId = threadIdRequestObject['threadId'];
    messages.insert(
      0,
      ChatMessage(
        text:
            'Hola! ¡Qué alegría saludarte! ¿En qué tema o materia te gustaría que te ayude hoy? 🤓📚',
        user: gptChatUser,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> getChatResponse(
    ChatMessage m,
  ) async {
    messages.insert(0, m);
    typingUsers.add(gptChatUser);
    notifyListeners();

    var uri = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/assistant/message');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"message": m.text, "threadId": threadId}),
    );

    if (response.statusCode == 200) {
      final responseBody = await jsonDecode(response.body);
      final chatResponse = ChatMessage(
        text: responseBody['messages'][0][0]['text']['value'],
        user: gptChatUser,
        createdAt: DateTime.now(),
      );
      messages.insert(0, chatResponse);
      typingUsers.clear();
      notifyListeners();
    }
  }
}
