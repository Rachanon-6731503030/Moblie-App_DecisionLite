import 'dart:math';
import 'package:flutter/material.dart';
import 'decision_result_screen.dart';
import 'decision_history.dart';


class AddOptionsScreen extends StatefulWidget {
  const AddOptionsScreen({super.key});

  @override
  State<AddOptionsScreen> createState() => _AddOptionsScreenState();
}

class _AddOptionsScreenState extends State<AddOptionsScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _options = [];

  void _addOption() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _options.add(_controller.text.trim());
      _controller.clear();
    });
  }

  void _decide() {
  if (_options.length < 2) return;

  final random = Random();
  final result = _options[random.nextInt(_options.length)];

  DecisionHistory.add(result);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DecisionResultScreen(
        result: result,
        onDecideAgain: () {
          setState(() {
            _options.clear(); // เคลียร์ตัวเลือก
          });
        },
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Options')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter an option',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
      child: ListView.builder(
        itemCount: _options.length,
        itemBuilder: (_, i) => Dismissible(
          key: Key(_options[i] + i.toString()),
            direction: DismissDirection.endToStart,
              background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
          ),
      onDismissed: (_) {
        setState(() {
          _options.removeAt(i);
        });
      },
      child: ListTile(
        title: Text(_options[i]),
      ),
    ),
  ),
),

            ElevatedButton(
              onPressed: _options.length >= 2 ? _decide : null,
              child: const Text('Decide'),
            ),
          ],
        ),
      ),
    );
  }
}
