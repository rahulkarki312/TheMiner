num truncateTo(num? val, int pt) {
  var x = val!.toStringAsFixed(pt);
  return double.parse(x);
}
