// pubspec.yaml
// dependencies:
//   flutter:
//     sdk: flutter
//   intl: ^0.17.0

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    title: 'Loan EMI Calculator',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
    ),
    home: LoanCalculator(),
  ));
}

class LoanCalculator extends StatefulWidget {
  @override
  _LoanCalculatorState createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  double principal = 0.0;
  double interestRate = 0.0;
  int term = 0;
  double emi = 0.0;
  double totalInterest = 0.0;
  double totalPayment = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loan EMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '32 Jess John TE_COMPS',
              style: TextStyle(
                color: Colors.tealAccent,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Principal Amount',
                labelStyle: TextStyle(color: Colors.tealAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  principal = double.parse(value);
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Interest Rate (%)',
                labelStyle: TextStyle(color: Colors.tealAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  interestRate = double.parse(value);
                });
              },
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Term (in years)',
                labelStyle: TextStyle(color: Colors.tealAccent),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  term = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  emi = calculateEMI(principal, interestRate, term);
                  totalInterest = emi * term * 12 - principal;
                  totalPayment = principal + totalInterest;
                });
              },
              child: Text('Calculate EMI'),
              style: ElevatedButton.styleFrom(
                primary: Colors.tealAccent,
                onPrimary: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              color: Colors.teal.shade800,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Loan EMI: ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(emi)}',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    Divider(color: Colors.white54),
                    Text(
                      'Total Interest Payable: ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(totalInterest)}',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    Divider(color: Colors.white54),
                    Text(
                      'Total Payment (Principal + Interest): ${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(totalPayment)}',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateEMI(double principal, double interestRate, int term) {
    double monthlyRate = interestRate / 1200;
    int numberOfPayments = term * 12;
    double emi =
        (principal * monthlyRate) / (1 - (1 / pow(1 + monthlyRate, numberOfPayments)));
    return emi;
  }
}