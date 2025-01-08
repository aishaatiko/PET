import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:personal_expense_tracker/utils/formatter.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';

class DetailExpenseScreen extends StatelessWidget {
  final Expense expense;

  const DetailExpenseScreen({Key? key, required this.expense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        shadowColor: Colors.black,
        elevation: 5.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/editExpenseScreen',
                  arguments: expense);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Expense'),
                  content: const Text(
                      'Are you sure you want to delete this expense?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<ExpenseProvider>(context, listen: false)
                            .deleteExpense(expense.id);
                        Navigator.of(ctx).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 800) {
              return DetailWebPage(expense: expense);
            } else {
              return DetailMobilePage(expense: expense);
            }
          },
        ),
      ),
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  final Expense expense;
  const DetailMobilePage({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (expense.category.isNotEmpty)
            Center(
              child: Image.asset(
                'images/${expense.category.toLowerCase()}.png',
                height: 100,
                width: 100,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              expense.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Rp ${expense.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oxygen',
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  expense.category,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oxygen',
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  formatDate(expense.date.toLocal()),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Oxygen',
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final Expense expense;

  const DetailWebPage({Key? key, required this.expense}) : super(key: key);

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
          if (widget.expense.category.isNotEmpty)
            Image.asset(
              'images/${widget.expense.category.toLowerCase()}.png',
              width: 150,
            ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.expense.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Divider(),
                const SizedBox(height: 8),
                Card(
                  surfaceTintColor: Colors.pink.shade50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'Rp ${formatCurrency(widget.expense.amount)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Oxygen',
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.pink.shade50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Category',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              widget.expense.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Oxygen',
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              formatDate(widget.expense.date.toLocal()),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Oxygen',
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
        ],
      ),
    );
  }
}
