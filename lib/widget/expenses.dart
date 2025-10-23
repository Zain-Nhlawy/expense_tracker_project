import 'package:expense_tracker_project/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker_project/widget/new_expense.dart';
import 'package:flutter/cupertino.dart';
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
  final List<Expense> _regestredExpenses = [
    Expense(
      title: 'buying food',
      amount: 10,
      category: Category.food,
      date: DateTime.now(),
    ),
    Expense(
      title: 'go to uni',
      amount: 4,
      category: Category.transfer,
      date: DateTime.now(),
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(context: context, builder: (ctx) => NewExpense());
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
          Expanded(child: ExpensesList(expenses: _regestredExpenses)),
        ],
      ),
    );
  }
}
