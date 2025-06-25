import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LlamaChatPage extends StatefulWidget {
  const LlamaChatPage({super.key});

  @override
  State<LlamaChatPage> createState() => _LlamaChatPageState();
}

class _LlamaChatPageState extends State<LlamaChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatHistory = [];
  bool _isLoading = false;

  Future<void> _sendMessage(String message) async {
    setState(() {
      _isLoading = true;
      _chatHistory.add({
        'role': 'user',
        'content': message,
      });
    });

    try {
      // Update the endpoint to include the specific API path
      final response = await http.post(
        Uri.parse('https://066e-34-90-174-201.ngrok-free.app/generate'),  // Add /api/generate or the correct endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': message,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String cleanResponse = responseData['response']
            .toString()
        // Remove any remaining instruction markers
            .replaceAll(RegExp(r'\[INST\].*?\[/INST\]'), '')
        // Remove any text that looks like a prompt-response pair
            .replaceAll(RegExp(r'Human:.*?Assistant:', caseSensitive: false), '')
            .replaceAll(RegExp(r'User:.*?Assistant:', caseSensitive: false), '')
        // Clean up any remaining artifacts
            .replaceAll('Assistant:', '')
            .replaceAll('Human:', '')
            .replaceAll('User:', '')
            .trim();

        setState(() {
          _chatHistory.add({
            'role': 'assistant',
            'content': cleanResponse,
          });
        });
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _chatHistory.add({
          'role': 'assistant',
          'content': 'Sorry, there was an error processing your request. Error: $e',
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panda'),
        backgroundColor: Colors.brown[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatHistory.isEmpty
                ? Center(
              child: Text(
                'Start a conversation with Panda!',
                style: TextStyle(color: Colors.grey[600]),
              ),
            )
                : ListView.builder(
              itemCount: _chatHistory.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final message = _chatHistory[index];
                return ChatBubble(
                  message: message['content']!,
                  isUser: message['role'] == 'user',
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        _sendMessage(text);
                        _messageController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.brown[300] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}