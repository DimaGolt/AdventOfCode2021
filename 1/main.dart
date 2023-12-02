import 'dart:io';

void main(List<String> args) async {
  var input = "1/.txt";

  List<String> file = await File(input).readAsLines();

  bool isFirst = true;
  int increses = 0;
  late int previous;

  for (String line in file) {
    if (isFirst) {
      isFirst = false;
      previous = int.parse(line);
    } else {
      if (previous < int.parse(line)) increses++;
      previous = int.parse(line);
    }
  }

  print(increses);
}
