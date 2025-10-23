import 'package:expense_tracker_project/models/expense.dart';
import 'package:expense_tracker_project/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.deletedExpense,
    required this.expenses,
  });
  final void Function(Expense deletedExpense) deletedExpense;
  final List<Expense> expenses;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          deletedExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
