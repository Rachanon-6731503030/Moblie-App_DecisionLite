import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DecisionHistory {
  static const String _historyKey = 'decision_history';
  static List<Map<String, String>> _history = [];

  static List<Map<String, String>> get history => _history;

  static Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_historyKey);
    if (historyJson != null) {
      final List<dynamic> decoded = jsonDecode(historyJson);
      _history = decoded.map((item) => Map<String, String>.from(item)).toList();
    }
  }

  static Future<void> add(String question, String result) async {
    final now = DateTime.now();

    final date = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final formattedDateTime = "$date at $time";

    _history.insert(0, {
      "question": question,
      "result": result,
      "date": formattedDateTime,
    });

    await _saveHistory();
  }

  static Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = jsonEncode(_history);
    await prefs.setString(_historyKey, historyJson);
  }

  static Future<void> clearHistory() async {
    _history.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}