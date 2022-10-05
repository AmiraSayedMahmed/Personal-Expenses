import 'package:expenses_plane/widgets/chart.dart';
import 'package:expenses_plane/widgets/new_transaction.dart';
import 'package:expenses_plane/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.red,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge:
                      TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /* Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),*/
  ];

  List<Transaction> get _resentTransaction {
    return _userTransactions.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  } // دي فانكشن عشان اعمل فيلتر للايام اللي عايزه اظهرها في التشارت واللي هم اخر 7 ايام في الاسبوع

  void _addNewTransaction(String txTitle, double txAmount , DateTime choseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choseDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id ;
      });
    });
  }

  void _startAddNewTransaction(BuildContext contxt) {
    showModalBottomSheet(
      context: contxt,
      builder: (_) {
        return GestureDetector(
          child: NewTransactions(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Chart(_resentTransaction),
          TransactionList(_userTransactions , _deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
