import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/chat/presentation/pages/chat_page.dart';

void main() {
  runApp(const HelpdeskChatApp());
}

class HelpdeskChatApp extends StatelessWidget {
  const HelpdeskChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helpdesk Chat',
      theme: AppTheme.lightTheme,
      home: const ChatPage(),
    );
  }
}
