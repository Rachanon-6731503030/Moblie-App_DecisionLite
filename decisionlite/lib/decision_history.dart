class DecisionHistory {
  static List<Map<String, String>> history = [];

  static void add(String question, String result) {
    final now = DateTime.now();
    
    final date = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final formattedDateTime = "$date at $time";

    history.insert(0, {
      "question": question,
      "result": result,
      "date": formattedDateTime,
    });
  }
}