
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid =  Uuid() ;

final formatter = DateFormat.yMd() ;

enum Category{food , travel , leisure , work}

const expenseIcons = {
  Category.food : Icons.lunch_dining ,
  Category.travel : Icons.flight_takeoff ,
  Category.leisure : Icons.movie ,
  Category.work : Icons.work ,

} ;

class Expense{
  Expense({
    required this.title ,
    required this.amount ,
    required this.date ,
    required this.expensetype ,

  }) : id = uuid.v4() ;
  String title ;
  double amount ;
  String id ;
  DateTime date ;
  Category expensetype ;
  
  String get formattedDate{
    return formatter.format(date) ;
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.expensetype == category)
            .toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount ;
    }
    return sum;
  }
}

