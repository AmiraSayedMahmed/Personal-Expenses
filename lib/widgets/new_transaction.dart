import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx); //constrctor

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
   DateTime? _selectedDate ;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController == null){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null ) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePiker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((pickedDate){
          if (pickedDate == null ){
            return;
          }
          setState(() {
          _selectedDate = pickedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                //border
              ),
              // onChanged: (value) => titleInput = value,
              controller: _titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitData,
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                ),
                //border
              ),
              //decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null ?
                    'No Date Chosen! '
              : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate as DateTime)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePiker,
                  child: Text(
                    'Pick A Date',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              onPressed: _submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
/*
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: submitData,
            ),
*/
          ],
        ),
      ),
    );
  }
}
