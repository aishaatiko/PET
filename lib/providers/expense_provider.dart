import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final _expenseBox = Hive.box<Expense>('expenses');
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
  List<Expense> get expenses => [..._expenseBox.values.toList()];
  List<String> get categories => [..._categories];
  Map<String, String> get categoryImages => _categoryImages;

  void addExpense(String title, double amount, String category) {
    var id = DateTime.now().toString();
    _expenseBox.put(
      id,
      Expense(
        id: id,
        title: title,
        amount: amount,
        date: DateTime.now(),
        category: category,
      ),
    );
    notifyListeners();
  }

  void deleteExpense(String id) async {
    await _expenseBox.delete(id);
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    _expenseBox.put(expense.id, expense);
    notifyListeners();
  }

  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }
}
