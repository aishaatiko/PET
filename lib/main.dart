import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:personal_expense_tracker/routes/router_generator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: MaterialApp(
        title: 'Personal Expense Tracker',
        theme: ThemeData(
          // primarySwatch: Colors.pink,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          // colorSchemeSeed: ,
          // brightness: ,
          useMaterial3: true,
          fontFamily: 'Staatliches',
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
