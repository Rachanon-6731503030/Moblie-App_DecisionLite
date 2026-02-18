import 'package:flutter/material.dart';
import 'decision_history.dart';

class DecisionHistoryScreen extends StatelessWidget {
  const DecisionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decision History')),
      body: DecisionHistory.history.isEmpty
          ? const Center(child: Text('No decisions yet'))
          : ListView.builder(
              itemCount: DecisionHistory.history.length,
              itemBuilder: (_, i) => 
            ListTile(
                leading: const Icon(Icons.history),
                title: Text(DecisionHistory.history[i].result),
                subtitle: Text(
                  DecisionHistory.history[i].time.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
          );
        }
    }
