import 'package:flutter/material.dart';
import 'add_options_screen.dart';
import 'decision_history_screen.dart';
import 'settings_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(const DecisionLiteApp());
}

class DecisionLiteApp extends StatefulWidget {
  const DecisionLiteApp({super.key});

  @override
  State<DecisionLiteApp> createState() => _DecisionLiteAppState();
}

class _DecisionLiteAppState extends State<DecisionLiteApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DecisionLite',
      themeMode: _themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainNavigation(
        onToggleTheme: toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final Function(bool) onToggleTheme;
  final bool isDarkMode;

  const MainNavigation({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const DecisionHistoryScreen(),
      SettingsScreen(
        onToggleTheme: widget.onToggleTheme,
        isDarkMode: widget.isDarkMode,
      ),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
  children: [

    // ===== Hero Header =====
    Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE3F2FD), // สีฟ้าอ่อน
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(Icons.lightbulb, size: 28, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "DecisionLite",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "What decision are\nyou making today?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),

    const SizedBox(height: 20),

    // ===== ส่วนปุ่มเดิมของคุณ =====
    Expanded(
      child: Center(
        child: SizedBox(
          width: 200,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddOptionsScreen(),
                ),
              );
            },
            child: const Text(
              'Start Decision',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    ),
  ],
),
    );
  }
}
