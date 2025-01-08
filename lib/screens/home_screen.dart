import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/models/expense.dart';
import 'package:personal_expense_tracker/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Expense> expenses = Provider.of<ExpenseProvider>(context).expenses;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PET: Personal Expense Tracker'),
        shadowColor: Colors.black,
        elevation: 5.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                themeProvider.themeData.brightness == Brightness.light
                    ? Icons.nightlight_round
                    : Icons.wb_sunny,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: Image.asset(
                      "images/cat-book.png",
                      color: Colors.black12,
                    ),
                  ),
                  const Text('No expenses added yet!'),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth <= 800) {
                  return const ExpenseList();
                } else if (constraints.maxWidth <= 1200) {
                  return const ExpenseGrid(gridCount: 2);
                } else {
                  return const ExpenseGrid(gridCount: 4);
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addExpenseScreen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final reversedExpenses = expenses.reversed.toList();

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            Navigator.pushNamed(context, '/detailExpenseScreen',
                arguments: reversedExpenses[index]);
          },
          child: Padding(
            padding: EdgeInsets.only(top: index == 0 ? 8.0 : 0.0),
            child: ExpenseItem(expense: reversedExpenses[index]),
          ),
        );
      },
    );
  }
}

class ExpenseGrid extends StatelessWidget {
  final int gridCount;

  const ExpenseGrid({Key? key, required this.gridCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context).expenses;

    return GridView.count(
      padding: const EdgeInsets.only(top: 16.0),
      crossAxisCount: gridCount,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: gridCount == 2 ? 4 : 2,
      children: expenses.reversed.map((expense) {
        return InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            Navigator.pushNamed(context, '/detailExpenseScreen',
                arguments: expense);
          },
          child: ExpenseItem(expense: expense),
        );
      }).toList(),
    );
  }
}
