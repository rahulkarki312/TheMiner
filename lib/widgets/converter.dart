import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:miner/models/coin.dart';
import 'tools/truncateDouble.dart';

class converter extends StatefulWidget {
  @override
  State<converter> createState() => _converterState();
}

class _converterState extends State<converter> {
  var sourceCurrency = TextEditingController();
  var beforeConv = TextEditingController();
  var destCurrency = TextEditingController();

  num? convertedAmount = 0.0;
  void convert() {
    String Src = sourceCurrency.text.toUpperCase();
    String dest = destCurrency.text.toUpperCase();
    num initialVal = num.parse(beforeConv.text);
    setState(() {
      coin result = coin(Src, initialVal).convertTo(dest);

      convertedAmount = result.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // TODO: implement build
    return Container(
      height: mediaQuery.size.height * 0.20,
      width: double.infinity,
      color: Theme.of(context).accentColor,
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: beforeConv,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => convert,
                ),
              ),
              Container(
                width: 70,
                child: TextField(
                  decoration: InputDecoration(labelText: "Source Currency"),
                  controller: sourceCurrency,
                  onSubmitted: (_) => convert,
                ),
              ),
              Icon(Icons.arrow_right),
              Container(
                width: 70,
                child: TextField(
                  decoration:
                      InputDecoration(labelText: "Destination Currency"),
                  controller: destCurrency,
                  onSubmitted: (_) => convert,
                ),
              ),
              FlatButton(
                  onPressed: convert,
                  child: Text(
                    "convert",
                  ))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(convertedAmount!.toDouble().toStringAsFixed(4))
        ],
      )),
    );
  }
}
