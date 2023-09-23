import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
// import 'package:expense_tracker/widgets/expenses.dart';

final formatter = DateFormat.yMd() ;

class NewExpense extends StatefulWidget{
  const NewExpense({super.key , required this.onAddExpense}) ;

  final void Function(Expense expense) onAddExpense ;

  @override
  State <NewExpense> createState() {
    return _NewExpenseState() ;
  }
 }
 class _NewExpenseState extends State<NewExpense>{
   final _titleController = TextEditingController() ;
   final _amountController = TextEditingController() ;

  Category _selectedCategory = Category.food ;

  DateTime ? _selectedDate ;
  void _presentDatePicker() async {
    DateTime now = DateTime.now() ;
    final pickedDate = await showDatePicker(context: context,
     initialDate: now, 
     firstDate: DateTime(now.year-1 , now.month , now.day), 
     lastDate: now) ;
     setState(() {
       _selectedDate = pickedDate ;
     });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text) ;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0 ;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context,
       builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const  Text('Please enter all the details in a valid format!!!'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx) ;
          }, child: const Text('Okay!'),
          )
        ],
       ),
       );
       return ;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text ,
        amount: enteredAmount ,
        date: _selectedDate! ,
        expensetype : _selectedCategory ,
       ) ,
    ) ;
    Navigator.pop(context) ;
  }

  @override
  void dispose(){
    _titleController.dispose() ;
    _amountController.dispose() ;
    super.dispose() ;
  }
  @override
  Widget build(BuildContext context){
    return Padding(padding: const EdgeInsets.all(16) ,
    child: Column(
      children: [
        TextField(controller: _titleController ,
        maxLength: 50,
        decoration: const InputDecoration(label: Text('Title')),
        ) ,
        Row(children: [
          Expanded(child: TextField(controller: _amountController ,
        keyboardType: TextInputType.number ,
        decoration: const InputDecoration(label: Text('Amount')),
        ) ,) ,
        const SizedBox(width:16) ,
        Expanded(child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!)) ,
            IconButton(onPressed:_presentDatePicker,
             icon: const Icon(Icons.calendar_month,))
        ],))
        ],),
        Row(children: [
          DropdownButton(
            value : _selectedCategory ,
            items:Category.values.map(
            (category)=>DropdownMenuItem(
              value : category ,
              child: Text(category.name))
          ).toList(),
          onChanged: (value){
            if(value==null){
              return ;
            }
            setState(() {
              _selectedCategory = value ;
            });
          },) ,
        ],) ,
        Row(children: [
          ElevatedButton(onPressed:
          _submitExpenseData ,
           child: const Text('Save Expense') ,
        ) ,
        ElevatedButton(onPressed: () {
          Navigator.pop(context) ;
        } ,
        child : const Text('Cancel') , 
        ) ,
        ],)
      ],
    ),) ;
  }
 }