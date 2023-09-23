import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart' ;
import 'package:expense_tracker/widgets/expenses list/expenses_list.dart'; 

class Expenses extends StatefulWidget{
  const Expenses({super.key}) ;
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState() ;
  } 
}
class _ExpensesState extends State<Expenses>{

  final List <Expense> _registerExpenses = [] ;
  //   Expense(title: 'Pizza' , amount: 340, date: DateTime.now() , expensetype: Category.food ,) , 
  //   Expense(title: 'Travelling', amount: 250 , date: DateTime.now(), expensetype: Category.travel)
  // ] ;

void _removeExpense(Expense expense){
  final expenseIndex = _registerExpenses.indexOf(expense) ;
  setState(() {
    _registerExpenses.remove(expense) ;
  });

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: 
      const Text(
        'Expense Deleted'
        ) ,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registerExpenses.insert(expenseIndex, expense) ;
    });
  }),)) ;
}

void _openAddExpenseOverlay(){
  showModalBottomSheet(
    isScrollControlled: true,
    context: context, builder: (ctx) => NewExpense(onAddExpense : _addExpense),) ;
}

  void _addExpense(Expense expense){
    setState(() {
      _registerExpenses.add(expense) ;
    });
  }

  @override
  Widget build(BuildContext context){
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!!!'),
    );
    if (_registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treasure Tracker'),
        centerTitle: true,
        actions: [
        IconButton(onPressed: () {
          return _openAddExpenseOverlay() ;
        }, icon: const Icon(Icons.add))
      ]),

      body: Column(children: [
      Chart(expenses: _registerExpenses) ,
      Expanded(
        child: mainContent ,
      )
    ],),) ;
  }
}