import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/chatbot_page_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatbotPageController>(context, listen: false)
          .fetchThread(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserOnSession, ChatbotPageController>(
      builder:
          (context, userOnSessionConsumer, chatbotPageControllerConsumer, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF9FA9FF),
            title: const Text('ExpertGPT'),
          ),
          body: DashChat(
            messageOptions: const MessageOptions(
              currentUserContainerColor: Color(0xFFFEC89F),
              containerColor: Color(0xFF9FA9FF),
              textColor: Colors.black,
              currentUserTextColor: Colors.black,
            ),
            currentUser: chatbotPageControllerConsumer.currentUser,
            onSend: (ChatMessage m) async {
              await chatbotPageControllerConsumer.getChatResponse(m);
              setState(() {});
            },
            messages: chatbotPageControllerConsumer.messages,
            typingUsers: chatbotPageControllerConsumer.typingUsers.isNotEmpty
                ? chatbotPageControllerConsumer.typingUsers
                : null,
          ),
        );
      },
    );
  }
}
