import 'package:flutter/material.dart';
import 'package:miner/models/coin.dart';
import 'tools/truncateDouble.dart';
import 'dart:math';

class interestCalc extends StatefulWidget {
  @override
  State<interestCalc> createState() => _interestCalcState();
}

class _interestCalcState extends State<interestCalc> {
  // interest Calculator
  Map<String, num> rates = {
    "VIP-1": 2.7, //10-99
    "VIP-2": 2.9, //100-499
    "VIP-3": 3.1, //500-1999
    "VIP-4": 3.3, //2000-4999
  };
  var principleAmtCtrl = TextEditingController();
  var timeCtrl = TextEditingController();
  var interestTypeCtrl = TextEditingController();

  num? sumUsdt = 0.0;
  num? sumNpr = 0.0;
  num? interestEarnedUsdt = 0.0;
  num? interestEarnedNpr = 0.0;

  void calcInterest() {
    double interest = 0;
    double principleAmt = double.parse(principleAmtCtrl.text);
    int time = int.parse(timeCtrl.text);
    String interestType = interestTypeCtrl.text.toUpperCase();
    double rate;

    if (interestType == 'S') {
      // Calculate simple
      if (principleAmt > 10 && principleAmt < 99) {
        interest = (principleAmt * time * 2.7) / 100; //rates['VIP-1']
      } else if (principleAmt > 100 && principleAmt < 499) {
        interest = (principleAmt * time * 2.9) / 100; //rates['VIP-1']
      } else if (principleAmt > 500 && principleAmt < 1999) {
        interest = (principleAmt * time * 3.1) / 100; //rates['VIP-1']
      }
    } else if (interestType == 'C') {
      // Calculate compound Interest
      if (principleAmt > 10 && principleAmt < 99) {
        interest = principleAmt * pow((1 + (2.7 / 100)), time) -
            principleAmt; //rates['VIP-1']
      } else if (principleAmt > 100 && principleAmt < 499) {
        interest = principleAmt * pow((1 + (2.9 / 100)), time) -
            principleAmt; //rates['VIP-1']
      } else if (principleAmt > 500 && principleAmt < 1999) {
        interest = principleAmt * pow((1 + (3.1 / 100)), time) -
            principleAmt; //rates['VIP-1']
      }
    }
    setState(() {
      sumUsdt = truncateTo(interest + principleAmt, 4);
      sumNpr = truncateTo((coin("USDT", sumUsdt).convertTo("NPR")).amount, 4);
      interestEarnedUsdt = truncateTo(interest, 4);
      interestEarnedNpr = truncateTo(
          (coin("USDT", interestEarnedUsdt).convertTo("NPR")).amount, 4);
    });
  }

// interest Calc ends

// target sum calc
  int targetDays = 0;

  double log10(double x) {
    return log(x) / log(10);
  }

  int numDays(num T, num P, num R) {
    // T = target amount, P = principle , R = Rate
    double d = log10(T / P) / log10((100 + R) / 100);
    return d.ceil();
  }

  var targetAmtCtrl = TextEditingController();
  var curAmtCtrl = TextEditingController();

  void calcTarget() {
    num targetSum = double.parse(targetAmtCtrl.text);
    num curAmt = double.parse(curAmtCtrl.text);
    int days = 0;
    if (curAmt > 10 && curAmt < 99) {
      days = numDays(targetSum, curAmt, 2.7);
    } else if (curAmt > 100 && curAmt < 499) {
      days = numDays(targetSum, curAmt, 2.9);
    } else if (curAmt > 500 && curAmt < 1999) {
      days = numDays(targetSum, curAmt, 3.1);
    } else {
      // too little amount ya poor thang
    }

    setState(() {
      targetDays = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      child: Column(children: [
        Container(
          height: mediaQuery.size.height * 0.32,
          width: mediaQuery.size.width * 0.9,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: mediaQuery.size.height * 0.05,
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Principle amount (in USDT)"),
                    controller: principleAmtCtrl,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Time (Days)"),
                  controller: timeCtrl,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "'S' for simple 'C' for compund"),
                  controller: interestTypeCtrl,
                ),
                Text("Total Sum = $sumUsdt USDT ~ Rs $sumNpr "),
                Text(
                    "Interest Earned = $interestEarnedUsdt USDT ~ Rs $interestEarnedNpr"),
                RaisedButton(child: Text("Calculate"), onPressed: calcInterest)
              ],
            ),
          ),
        ),

        // Target interest Calc
        Container(
          height: mediaQuery.size.height * 0.30,
          width: mediaQuery.size.width * 0.9,
          child: Card(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Current Amount"),
                  controller: curAmtCtrl,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Target Amount"),
                  controller: targetAmtCtrl,
                ),
                RaisedButton(
                  onPressed: calcTarget,
                  child: Text("calculate"),
                ),
                Text("$targetDays days to go")
              ],
            ),
          ),
        )
      ]),
    );
  }
}
