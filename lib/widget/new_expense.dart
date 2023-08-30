import 'package:flutter/material.dart';
import 'package:extense_tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selecteDate;
  Category _selectedCategory = Category.leisure;
  // Es necesario eliminar el controlador cuando se cierra el Modal

  @override //Elimina los controladores de lo inputs
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selecteDate = pickedDate;
    });
  }

  void _submitExpense() {
    final isTitleInvalid = _titleController.text.trim().isEmpty;
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (isTitleInvalid || amountIsInvalid || _selecteDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    final Expense newExpense = Expense(
      amount: enteredAmount,
      category: _selectedCategory,
      date: _selecteDate!,
      title: _titleController.text,
    );
    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Text(
                      _selecteDate != null
                          ? formatter.format(_selecteDate as DateTime)
                          : 'No Date Selected',
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) return;
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text('Save Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
