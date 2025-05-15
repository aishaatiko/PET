import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:personal_expense_tracker/utils/formatter.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.decimalPattern('id');
    final categoryImages = Provider.of<ExpenseProvider>(context).categoryImages;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            // categoryImages[expense.category] ?? 'assets/images/other.png',
            // fit: BoxFit.fitHeight,
            Icons.pets,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                expense.title,
                style: const TextStyle(
                  fontFamily: 'Oxygen',
                  overflow: TextOverflow.ellipsis,
                ),
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ),
            Text(
              formatDate(expense.date.toLocal()),
            ),
          ],
        ),
        subtitle: Text(
          'Rp ${formatter.format(expense.amount)}',
          style: const TextStyle(
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
