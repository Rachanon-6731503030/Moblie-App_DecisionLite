import 'package:flutter/material.dart';
import 'decision_history.dart';

class DecisionHistoryScreen extends StatelessWidget {
  const DecisionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final history = DecisionHistory.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Decision History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: history.isEmpty
            ? const Center(
                child: Text("No history yet."),
              )
            : ListView.separated(
                itemCount: history.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = history[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["question"] ?? "",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Result: ${item["result"]}",
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item["date"] ?? "",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
