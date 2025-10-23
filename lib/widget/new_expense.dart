import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker_project/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
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

  Category _selectedCategory = Category.food;
  DateTime? selectedDate;
  @override
  Widget build(context) {
    void datePecker() async {
      final now = DateTime.now();
      final fisrt = DateTime(now.year - 1, now.month, now.day);
      final datePeck = await showDatePicker(
        context: context,
        firstDate: fisrt,
        lastDate: now,
      );
      setState(() {
        selectedDate = datePeck;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          TextField(
            controller: _enteredController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _enteredAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('amount'),
                  ),
                ),
              ),
              SizedBox(width: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    selectedDate == null
                        ? "no date "
                        : formatter.format(selectedDate!),
                  ),
                  IconButton(
                    onPressed: datePecker,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
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
                onPressed: () {
                  print(selectedDate);
                },
                child: const Text('save expense'),
              ),
              SizedBox(width: 20),
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
