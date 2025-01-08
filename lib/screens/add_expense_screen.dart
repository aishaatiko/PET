import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  List<String> _categories = [];
  String? _selectedCategory;

  void _saveExpense() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    Provider.of<ExpenseProvider>(context, listen: false)
        .addExpense(title, amount, _selectedCategory!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _categories = Provider.of<ExpenseProvider>(context).categories;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Expense'),
        shadowColor: Colors.black,
        elevation: 5.0,
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
                onPressed: _saveExpense,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.pink.shade50,
                ),
                child: const Text('Add Expense'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
