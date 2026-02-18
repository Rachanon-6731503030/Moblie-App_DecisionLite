class DecisionItem {
  final String result;
  final DateTime time;

  DecisionItem(this.result, this.time);
}

class DecisionHistory {
  static final List<DecisionItem> history = [];

  static void add(String result) {
    history.insert(0, DecisionItem(result, DateTime.now()));
  }
}

