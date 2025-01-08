import 'package:flutter/foundation.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];
  final List<Expense> mockExpenses = [
    Expense(
      id: 'e2',
      title: 'Bus Ticket',
      amount: 50000,
      category: 'Transport',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Expense(
      id: 'e1',
      title: 'Groceries',
      amount: 20000,
      category: 'Shopping',
      date: DateTime.now(),
    ),
  ];
  final Map<String, String> _categoryImages = {
    'Food': 'images/food.png',
    'Transport': 'images/transport.png',
    'Shopping': 'images/shopping.png',
    'Health': 'images/health.png',
    'Other': 'images/other.png',
  };
  // Categories
  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Health',
    'Other'
  ];
  List<Expense> get expenses =>
      [...mockExpenses, ...mockExpenses, ...mockExpenses, ..._expenses];
  List<String> get categories => [..._categories];
  Map<String, String> get categoryImages => _categoryImages;

  void addExpense(String title, double amount, String category) {
    _expenses.add(
      Expense(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now(),
        category: category,
      ),
    );
    notifyListeners();
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  void updateExpense(String id, String title, double amount, String category) {
    final index = _expenses.indexWhere((expense) => expense.id == id);
    if (index != -1) {
      _expenses[index] = Expense(
        id: _expenses[index].id,
        title: title,
        amount: amount,
        category: category,
        date: _expenses[index].date,
      );
      notifyListeners();
    }
  }
}
