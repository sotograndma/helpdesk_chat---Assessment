import 'package:flutter/material.dart';
import 'package:helpdesk_chat/features/chat/domain/chat_message.dart';
import 'package:helpdesk_chat/features/chat/domain/chat_thread.dart';
import 'message_bubble.dart';
import 'conversation_list_item.dart';
import '../../data/chat_bot_service.dart';

class DesktopChatLayout extends StatefulWidget {
  const DesktopChatLayout({super.key});

  @override
  State<DesktopChatLayout> createState() => _DesktopChatLayoutState();
}

class _DesktopChatLayoutState extends State<DesktopChatLayout> {
  final List<ChatThread> _threads = [
    ChatThread(
      id: '1',
      name: 'Cameron Williamson',
      subtitle: "Can’t log in",
      lastTime: 'Tue',
      status: 'Open',
      avatarUrl: 'assets/images/3.jpg',
    ),
    ChatThread(
      id: '2',
      name: 'Kristin Watson',
      subtitle: 'Error message',
      lastTime: 'Tue',
      status: 'Tue',
      avatarUrl: 'assets/images/1.jpg',
    ),
    ChatThread(
      id: '3',
      name: 'Kathryn Murphy',
      subtitle: 'Payment issue',
      lastTime: 'Mon',
      status: 'Mon',
      avatarUrl: 'assets/images/2.jpg',
    ),
    ChatThread(
      id: '4',
      name: 'Ralph Edwards',
      subtitle: 'Account assist…',
      lastTime: 'Mon',
      status: 'Mon',
      avatarUrl: 'assets/images/4.jpg',
    ),
  ];

  int _selectedIndex = 0;

  final List<ChatMessage> _messages = [
    ChatMessage(id: '1', text: "Hello!", time: '9:30 AM', isMe: false),
  ];

  final ChatBotService _botService = ChatBotService(useOpenAI: false);

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          time: '9:40 AM',
          isMe: true,
        ),
      );
    });

    _controller.clear();

    final replyText = await _botService.getReply(text);

    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: replyText,
          time: '9:41 AM',
          isMe: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedThread = _threads[_selectedIndex];

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 320,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Helpdesk Chat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, size: 18, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Search',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: _threads.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final thread = _threads[index];
                      return ConversationListItem(
                        thread: thread,
                        isSelected: index == _selectedIndex,
                        isOpen: index == _selectedIndex,
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x11000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              selectedThread.avatarUrl,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Helpdesk Chat',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                selectedThread.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2DD4BF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Open',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5F7FB),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return MessageBubble(
                          text: msg.text,
                          time: msg.time,
                          isMe: msg.isMe,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Message',
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _handleSend(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _handleSend,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF2F80ED),
                          ),
                          child: const Icon(
                            Icons.send,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
