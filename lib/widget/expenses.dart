import 'package:expense_tracker_project/widget/chart/chart.dart';
import 'package:expense_tracker_project/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker_project/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_project/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _addExpense(newExpense) {
    setState(() {
      regestredExpenses.add(newExpense);
    });
  }

  void _deleteExpense(newExpense) {
    var index = regestredExpenses.indexOf(newExpense);
    setState(() {
      regestredExpenses.remove(newExpense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('expense dleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              regestredExpenses.insert(index, newExpense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> regestredExpenses = [
    Expense(
      amount: 20,
      date: DateTime.now(),
      title: 'ppdfs',
      category: Category.food,
    ),
    Expense(
      amount: 20,
      date: DateTime.now(),
      title: 'ppdfs',
      category: Category.food,
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) => NewExpense(addExpense: _addExpense),
    );
  }

  @override
  Widget build(context) {
    Widget content = Expanded(
      child: const Center(child: Text('no expenses yet ')),
    );
    if (regestredExpenses.isNotEmpty) {
      content = Expanded(
        child: ExpensesList(
          expenses: regestredExpenses,
          deletedExpense: _deleteExpense,
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Chart(expenses: regestredExpenses),
          Flexible(child: content),
          SizedBox(height: 25),
          FloatingActionButton(
            onPressed: _openAddExpense,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
