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

    DecisionHistory.add("My Decision", result);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DecisionResultScreen(
          result: result,
          onDecideAgain: () {
            setState(() {
              _options.clear();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Options'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                onSubmitted: (_) => _addOption(),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Enter an option...',
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_rounded, color: Colors.white),
                      onPressed: _addOption,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Your Options (${_options.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 12),

              Expanded(
                child: _options.isEmpty
                    ? Center(
                        child: Text(
                          'Add at least 2 options\nto let the magic happen ✨',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _options.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Dismissible(
                              key: Key(_options[i] + i.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.redAccent,
                                child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 28),
                              ),
                              onDismissed: (_) {
                                setState(() {
                                  _options.removeAt(i);
                                });
                              },
                              child: Card(
                                margin: EdgeInsets.zero,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                  leading: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                                    child: Text(
                                      '${i + 1}',
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _options[i],
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: _options.length >= 2 ? _decide : null,
                  icon: const Icon(Icons.auto_awesome, size: 24),
                  label: Text(
                    _options.length >= 2 ? 'Decide for me!' : 'Need ${_options.length == 1 ? "1 more" : "2"} options',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: theme.colorScheme.onSurface.withOpacity(0.12),
                    disabledForegroundColor: theme.colorScheme.onSurface.withOpacity(0.38),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}