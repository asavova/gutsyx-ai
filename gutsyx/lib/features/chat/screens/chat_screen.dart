import 'package:flutter/material.dart';
import 'package:gutsyx/core/theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'role': 'ai', 'text': 'Hello! I am your GutsyX AI assistant. How can I help you with your digestive health today?'}
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _messages.add({'role': 'user', 'text': _controller.text});
      _controller.clear();
      // Simulate AI response
      _messages.add({'role': 'ai', 'text': 'I am analyzing your history... Based on your last scan (Bristol 4), you are doing great! Keep drinking water.'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_awesome, color: AppTheme.metallicPurple),
            SizedBox(width: 8),
            Text('AI Health Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isAI = msg['role'] == 'ai';
                return Align(
                  alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isAI ? Colors.white : AppTheme.electricBlue,
                      borderRadius: BorderRadius.circular(20).copyWith(
                        bottomLeft: isAI ? const Radius.circular(0) : const Radius.circular(20),
                        bottomRight: isAI ? const Radius.circular(20) : const Radius.circular(0),
                      ),
                      boxShadow: [
                        if (isAI) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
                      ],
                    ),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(color: isAI ? Colors.black : Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about your gut health...',
                        filled: true,
                        fillColor: AppTheme.surfaceWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: AppTheme.metallicPurple,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
