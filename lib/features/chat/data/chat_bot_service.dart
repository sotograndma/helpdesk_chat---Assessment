import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatBotService {
  static const String _apiKey = 'API_KEY';
  final bool useOpenAI;

  ChatBotService({this.useOpenAI = false});

  Future<String> getReply(String userMessage) async {
    if (!useOpenAI || _apiKey.isEmpty || _apiKey == 'API_KEY') {
      return _dummyReply(userMessage);
    }

    try {
      return await _openAIReply(userMessage);
    } catch (_) {
      return _dummyReply(userMessage);
    }
  }

  Future<String> _dummyReply(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1));

    if (userMessage.toLowerCase().contains('screenshot')) {
      return 'Sure, please send a screenshot of the error so we can check further.';
    }

    if (userMessage.toLowerCase().contains('hello') ||
        userMessage.toLowerCase().contains('hi')) {
      return 'Hello! How can I help you today?';
    }

    return "Got it, we\'ll check this for you and get back as soon as possible.";
  }

  Future<String> _openAIReply(String userMessage) async {
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a friendly helpdesk support agent for an app. Answer briefly and clearly.',
          },
          {'role': 'user', 'content': userMessage},
        ],
        'max_tokens': 120,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final content = data['choices'][0]['message']['content'] as String? ?? '';
      return content.trim();
    } else {
      return 'Sorry, there was a problem contacting the AI. Please try again later.';
    }
  }
}
