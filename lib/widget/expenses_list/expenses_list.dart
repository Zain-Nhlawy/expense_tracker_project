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
    return SizedBox(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
      
          onDismissed: (direction) {
            deletedExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
