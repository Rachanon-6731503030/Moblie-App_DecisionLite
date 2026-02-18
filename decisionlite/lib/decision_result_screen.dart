import 'dart:async';
import 'package:flutter/material.dart';

class DecisionResultScreen extends StatefulWidget {
  final String result;
  final VoidCallback onDecideAgain;

  const DecisionResultScreen({
    super.key,
    required this.result,
    required this.onDecideAgain,
  });

  @override
  State<DecisionResultScreen> createState() => _DecisionResultScreenState();
}

class _DecisionResultScreenState extends State<DecisionResultScreen> {
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    // หน่วงเวลา 2 วินาที ก่อนแสดงผลลัพธ์
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showResult = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decision Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: _showResult
                  ? Text(
                      widget.result,
                      key: const ValueKey('result'),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      'Deciding...',
                      key: ValueKey('loading'),
                      style: TextStyle(fontSize: 22),
                    ),
            ),
            const SizedBox(height: 40),
            if (_showResult) ...[
              ElevatedButton(
                onPressed: () {
                  widget.onDecideAgain();
                  Navigator.pop(context);
                },
                child: const Text('Decide Again'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Back to Home'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
