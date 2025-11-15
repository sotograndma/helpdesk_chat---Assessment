import 'package:flutter/material.dart';
import '../../data/chat_bot_service.dart';
import '../../domain/chat_message.dart';
import '../../domain/chat_thread.dart';
import '../widgets/message_bubble.dart';
import '../widgets/conversation_list_item.dart';

class MobileChatLayout extends StatefulWidget {
  const MobileChatLayout({super.key});

  @override
  State<MobileChatLayout> createState() => _MobileChatLayoutState();
}

class _MobileChatLayoutState extends State<MobileChatLayout> {
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

  int _selectedThreadIndex = 0;
  bool _isSidebarOpen = false;

  final List<ChatMessage> _messages = [
    ChatMessage(id: '1', text: "Hello!", time: '9:30 AM', isMe: false),
  ];

  final TextEditingController _controller = TextEditingController();
  final ChatBotService _botService = ChatBotService(useOpenAI: false);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
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
    final selectedThread = _threads[_selectedThreadIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_isSidebarOpen ? Icons.close : Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isSidebarOpen = !_isSidebarOpen;
            });
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Helpdesk Chat', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              selectedThread.name,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
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
              const Divider(height: 1),
              SafeArea(
                top: false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      const SizedBox(width: 8),
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
              ),
            ],
          ),

          if (_isSidebarOpen)
            Positioned.fill(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Helpdesk Chat',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
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
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            itemCount: _threads.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final thread = _threads[index];
                              return ConversationListItem(
                                thread: thread,
                                isSelected: index == _selectedThreadIndex,
                                isOpen: index == _selectedThreadIndex,
                                onTap: () {
                                  setState(() {
                                    _selectedThreadIndex = index;
                                    _isSidebarOpen = false;
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSidebarOpen = false;
                        });
                      },
                      child: Container(color: Colors.black26),
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
