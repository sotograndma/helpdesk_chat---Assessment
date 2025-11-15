import 'package:flutter/material.dart';
import '../widgets/mobile_chat_layout.dart';
import '../widgets/desktop_chat_layout.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        if (width < 600) {
          return const MobileChatLayout();
        } else {
          return const DesktopChatLayout();
        }
      },
    );
  }
}
