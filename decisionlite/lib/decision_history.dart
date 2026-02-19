class DecisionHistory {
  static List<Map<String, String>> history = [];

  static void add(String question, String result) {
    history.insert(0, {
      "question": question,
      "result": result,
      "date": DateTime.now().toString().split(' ')[0],
    });
  }
}
