import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 64, 214, 129)) ;

var kDarkColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 252, 158, 58) ,
  brightness: Brightness.dark) ;

void main() {
  runApp(
     MaterialApp(

      darkTheme: ThemeData.dark().copyWith(
        useMaterial3 : true, 
        colorScheme: kDarkColorScheme ,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer ,
          margin: const EdgeInsets.symmetric(horizontal: 16 ,
          vertical: 8)
        ) ,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer ,
            foregroundColor: kDarkColorScheme.onPrimaryContainer , 
          )
        ) ,
        ),


      debugShowCheckedModeBanner : false ,
      theme: ThemeData().copyWith(
        useMaterial3: true ,
        colorScheme: kColorScheme ,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer ,
          foregroundColor: kColorScheme.primaryContainer 
        ) ,
        cardTheme: CardTheme().copyWith(
          color : kColorScheme.secondaryContainer ,
          margin: const EdgeInsets.symmetric(horizontal: 16 ,
          vertical: 8)
        ) ,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer ,
          )
        ) ,
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold ,
            color : kColorScheme.onSecondaryContainer ,
            fontSize: 20 ,
          )
        )
      ),
      home: const Expenses() 
  ));
}