import 'package:extense_tracker_app/widget/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Futebol Academy',
        amount: 300,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Hamburguer',
        amount: 9.50,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Train Card',
        amount: 50,
        date: DateTime.now(),
        category: Category.travel),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ExpensesList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
