import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatServiceProvider = Provider((ref) => ChatService());

class ChatService {
  static const String _apiKey = 'AIzaSyDXgCgQFN5IZOmS2ME-S7dHieTRGJLiNtI';
  final GenerativeModel _model;

  ChatService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: _apiKey,
        );

  Future<String> getResponse(String message, List<Map<String, dynamic>> historyContext) async {
    // Convert history logs to a string context for the AI
    final contextString = historyContext.map((e) => 
      'Date: ${e['timestamp']}, Bristol Scale: ${e['bristolScale']}, Color: ${e['color']}'
    ).join('\n');

    final prompt = [
      Content.text(
        'You are a health assistant. '
        'Here is the user\'s recent stool history for context:\n$contextString\n\n'
        'User: $message'
      )
    ];

    final response = await _model.generateContent(prompt);
    return response.text ?? 'I am sorry, I could not process that request.';
  }
}
