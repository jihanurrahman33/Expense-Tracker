import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expense,
  });
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expense = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();
  final Category category;
  final List<Expense> expense;
  double get totalExpense {
    double sum = 0;
    for (final expense in expense) {
      sum += expense.amount;
    }
    return sum;
  }
}
