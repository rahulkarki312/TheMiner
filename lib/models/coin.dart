Map<String, num> coinValues = {
  // Base : USD
  "USDT": 1.0,
  "NPR": 0.00785,
  "ETH": 1827.87,
  "BTC": 24154.0,
  "TRX": 0.07
};

void updateCoin(String name, double newValue) {
  coinValues[name] = newValue;
}

class coin {
  String? name;
  num? amount;
  coin(this.name, this.amount);
  //convert a coin to another coin of name 'convName'

  coin convertTo(String convName) {
    num? factor = coinValues[name]! / (coinValues[convName] as double);

    return coin(convName, (amount! * factor));
  }
}


// void main(){
 
//   double? converted = (coin("USDT", 36.91).convertTo("NPR")).amount;
//   print(converted);
// //   updateCoin("USDT", 1.3);
  
// }
