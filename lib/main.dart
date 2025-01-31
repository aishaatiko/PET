import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_expense_tracker/models/expense.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:personal_expense_tracker/providers/theme_provider.dart';
import 'package:personal_expense_tracker/routes/router_generator.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive
  Hive.registerAdapter(ExpenseAdapter()); // Register adapter for your model
  await Hive.openBox<Expense>('expenses'); // Open a box for your expenses

  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeSynchronously(); // Synchronous loading

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Personal Expense Tracker',
      theme: themeProvider.themeData,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
