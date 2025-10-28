import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_project/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addExpense, super.key});
  final void Function(Expense newExpense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final formatter = DateFormat.yMd();
  final _enteredController = TextEditingController();
  final _enteredAmountController = TextEditingController();
  @override
  void dispose() {
    _enteredController.dispose();
    _enteredAmountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enterdAmount = double.tryParse(_enteredAmountController.text);
    final inValidAmount = enterdAmount == null;
    if (inValidAmount ||
        _enteredController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('invaled data'),
          content: Text('some of the data are missing or invaid'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.addExpense(
      Expense(
        amount: enterdAmount,
        date: _selectedDate!,
        title: _enteredController.text,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  Category _selectedCategory = Category.food;
  DateTime? _selectedDate;
  void datePecker() async {
    final now = DateTime.now();
    final fisrt = DateTime(now.year - 1, now.month, now.day);
    final datePeck = await showDatePicker(
      context: context,
      firstDate: fisrt,
      lastDate: now,
    );
    setState(() {
      _selectedDate = datePeck;
    });
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            controller: _enteredController,
            maxLength: 50,
            decoration: const  InputDecoration(label: Text('title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  controller: _enteredAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('amount'),
                  ),
                ),
              ),
             const SizedBox(width: 50),
              Row(
                mainAxisAlignment:  MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == null
                        ? "no date "
                        : formatter.format(_selectedDate!),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: datePecker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
         const  SizedBox(height: 15),

          Row(
            children: [
             DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),

              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('save expense'),
              ),
              SizedBox(width: 3),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
