import 'dart:ffi';
import 'package:miner/widgets/interestCalc.dart';

import 'models/coin.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'widgets/converter.dart';

void main() => runApp(MineApp());

class MineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.amber, accentColor: Colors.blueGrey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((context) {
                      return Container(
                        height: mediaQuery.size.height * 0.5,
                        color: Theme.of(context).accentColor,
                        child: Card(
                          child: Column(
                            children: [
                              Text("Modify values"),
                              // coinValues.keys.toList()
                            ],
                          ),
                        ),
                      );
                    }));
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
      ),
      body: Column(children: [
        // converter
        converter(),

        interestCalc()
      ]),
    );
  }
}

// class convDropdown extends StatefulWidget {
//   final String selected;
//   convDropdown(this.selected);
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return convDropdownState();
//   }
// }

// class convDropdownState extends State {

//   String currencySelected = "USDT";
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return DropdownButton<String>(
//       value: currencySelected,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       dropdownColor: Theme.of(context).primaryColor,
//       focusColor: Theme.of(context).accentColor,
//       style: const TextStyle(color: Colors.white),
//       underline: Container(
//         height: 2,
//         color: Theme.of(context).primaryColor,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           currencySelected = newValue!;
//         });
//       },
//       items: <String>['USDT', 'ETH', 'BTC', 'TRX']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
