class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}
