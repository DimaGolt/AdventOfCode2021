import 'dart:io';

void main() async {
  var path = '8/input.txt';
  List<String> file = await File(path).readAsLines();
  List<List<String>> paterns = [];
  List<List<String>> outputs = [];

  for (var line in file) {
    var splitLine = line.split('|');
    paterns.add(splitLine.first.split(' '));
    outputs.add(splitLine.last.split(' '));
  }

  int sum = 0;
  for (var output in outputs) {
    for (var digit in output) {
      if (digit.length == 2 ||
          digit.length == 4 ||
          digit.length == 3 ||
          digit.length == 7) sum++;
    }
  }

  print(sum);
}
