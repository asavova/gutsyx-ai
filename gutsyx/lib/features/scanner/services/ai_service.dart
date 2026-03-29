import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiServiceProvider = Provider((ref) => AIService());

class AIService {
  final GenerativeModel _model;

  AIService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          // Get API key from build-time environment variable
          apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
          systemInstruction: Content.system(
            'You are GutsyX AI, a highly sophisticated clinical gastrointestinal health analyst. '
            'Your purpose is to provide professional, objective, and empathetic analysis based on the Bristol Stool Chart. '
            'Maintain a medical but accessible tone. Avoid alarmist language. '
            'Always prioritize scientific metrics like consistency, transit time indicators, and hydration markers. '
            'Strictly adhere to providing a JSON response only.'
          ),
        );

  Future<Map<String, dynamic>> analyzeStool(Uint8List imageBytes) async {
    final prompt = [
      Content.multi([
        TextPart(
          'Analyze the provided specimen image for digestive diagnostic markers. '
          'Evaluate the following parameters: '
          '1. Bristol Stool Form Scale: Determine the precise type (1-7). '
          '2. Colorimetry: Identify the exact pigment (e.g., Deep Umber, Ochre, Sepia). '
          '3. Hydration Status: Assess mucosal moisture and fragmentation. '
          '4. Clinical Insight: Provide a professional, actionable recommendation (max 150 chars). '
          '5. Holistic Gut Score: Calculate a proprietary health metric (0-100) based on deviation from Bristol Types 3 and 4. '
          '\n\n'
          'Required JSON structure: '
          '{ "bristolScale": int, "color": string, "hydrationLevel": string, "aiTip": string, "healthScore": int }'
        ),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    try {
      final response = await _model.generateContent(prompt);
      final text = response.text;
      
      if (text == null) throw Exception('Diagnostic module failed to return data.');
      
      final cleanText = text.replaceAll('```json', '').replaceAll('```', '').trim();
      return jsonDecode(cleanText) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('GutsyX AI Analysis Error: \$e');
    }
  }
}
