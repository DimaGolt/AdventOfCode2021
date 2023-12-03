import 'dart:io';

void main() async {
  var path = '7/input.txt';
  String file = await File(path).readAsString();
  List<int> crabs = file.split(',').map((e) => int.parse(e)).toList();
  int max = crabs.fold(
      0,
      (previousValue, element) =>
          previousValue < element ? element : previousValue);
  int cheapest = double.maxFinite.toInt();
  for (var i = 0; i < max; i++) {
    int result = 0;
    crabs.forEach((element) => result += (element - i).abs());
    if (result < cheapest) cheapest = result;
  }

  print(cheapest);
}
