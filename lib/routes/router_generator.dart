import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/expense.dart';
import 'package:personal_expense_tracker/screens/add_expense_screen.dart';
import 'package:personal_expense_tracker/screens/detail_expense_screen.dart';
import 'package:personal_expense_tracker/screens/edit_expense_screen.dart';
import 'package:personal_expense_tracker/screens/home_screen.dart';
// import 'package:personal_expense_tracker/screens/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final args = settings.name;
    switch (args) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          // const LoginScreen(),
        );
      case "/addExpenseScreen":
        return MaterialPageRoute(
          builder: (context) => const AddExpenseScreen(),
        );
      case "/detailExpenseScreen":
        return MaterialPageRoute(
          builder: (context) =>
              DetailExpenseScreen(expense: settings.arguments as Expense),
        );
      case "/editExpenseScreen":
        return MaterialPageRoute(
          builder: (context) =>
              EditExpenseScreen(expense: settings.arguments as Expense),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}
