import 'package:flutter/foundation.dart' hide Category;
import 'package:hive/hive.dart';
import 'package:personal_expense_tracker/models/expense.dart';
import 'package:personal_expense_tracker/models/category.dart';

class ExpenseProvider with ChangeNotifier {
  final _expenseBox = Hive.box<Expense>('expenses');
  final categoryBox = Hive.box<Category>('categories');

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

  void addCategory(String name) {
    final newCategory = Category(
      id: DateTime.now().toString(),
      name: name,
    );
    categoryBox.put(newCategory.id, newCategory); // Add the category
    notifyListeners();
  }

  void deleteCategoryAndRefresh(String id) {
    categoryBox.delete(id); // Delete the category
    notifyListeners();
  }

  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }
}
