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
    setState(() {
      regestredExpenses.remove(newExpense);
    });
  }

  final List<Expense> regestredExpenses = [];

  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpense: _addExpense),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Life Expenses'),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text('chart'),
          Expanded(
            child: ExpensesList(
              expenses: regestredExpenses,
              deletedExpense: _deleteExpense,
            ),
          ),
        ],
      ),
    );
  }
}
