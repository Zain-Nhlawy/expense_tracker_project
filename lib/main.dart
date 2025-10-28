import 'package:expense_tracker_project/widget/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'drawer_screen.dart';

var kColorSchem = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 146, 102, 160),
);

var kDarkColorSchem = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 196, 72, 165),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    fn,
  ) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = true;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDark = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorSchem,
        cardTheme: const CardThemeData().copyWith(
          color: kDarkColorSchem.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorSchem.onPrimaryContainer,
            foregroundColor: kDarkColorSchem.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDarkColorSchem.onPrimaryContainer,
            fontSize: 20,
          ),
        ),
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kDarkColorSchem.primaryContainer,
          foregroundColor: kDarkColorSchem.onPrimaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorSchem,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorSchem.onPrimaryContainer,
          foregroundColor: kColorSchem.primaryContainer,
        ),
        cardTheme: const CardThemeData().copyWith(
          color: kColorSchem.primaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchem.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchem.onSecondaryContainer,
            fontSize: 20,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Expense Tracker')),
        drawer: DrawerScreen(isDark: _isDark, onThemeChanged: _toggleTheme),
        body: const Expenses(),
      ),
    );
  }
}
