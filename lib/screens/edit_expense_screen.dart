import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/providers/expense_provider.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  const EditExpenseScreen({Key? key, required this.expense}) : super(key: key);

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.expense.title);
    _amountController =
        TextEditingController(text: widget.expense.amount.toStringAsFixed(0));
    _selectedCategory = widget.expense.category;
  }

  void _saveChanges() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _selectedCategory == null) {
      return;
    }

    Provider.of<ExpenseProvider>(context, listen: false).updateExpense(
      Expense(
        id: widget.expense.id,
        title: title,
        amount: amount,
        category: _selectedCategory!,
        date: widget.expense.date,
      ),
    );

    Navigator.pushReplacementNamed(context, '/detailExpenseScreen',
        arguments: Provider.of<ExpenseProvider>(context, listen: false)
            .expenses
            .where((item) => item.id == widget.expense.id)
            .first);
  }

  @override
  Widget build(BuildContext context) {
    _categories = Provider.of<ExpenseProvider>(context).categories;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Expense'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        bool isPortrait = constraints.maxWidth < 800;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isPortrait
                  ? Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                          style: const TextStyle(fontFamily: 'Oxygen'),
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                        ),
                        TextField(
                          controller: _amountController,
                          decoration:
                              const InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontFamily: 'Oxygen'),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            style: const TextStyle(fontFamily: 'Oxygen'),
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                          ),
                        ),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration:
                                const InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontFamily: 'Oxygen'),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Category'),
                focusColor: Colors.transparent,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.pink.shade50,
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
