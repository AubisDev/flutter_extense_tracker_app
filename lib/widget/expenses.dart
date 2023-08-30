import 'package:extense_tracker_app/widget/expenses_list/expenses_list.dart';
import 'package:extense_tracker_app/widget/new_expense.dart';
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

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 255, 193, 7),
        title: const Text('Expenses Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ExpensesList(
                  expenses: _registeredExpenses,
                  onRemoveExpense: _removeExpense))
        ],
      ),
    );
  }
}
