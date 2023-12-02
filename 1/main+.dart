import 'dart:io';

void main(List<String> args) async {
  var input = "1/.txt";

  List<String> file = await File(input).readAsLines();

  int increses = 0;
  List<int> previous = [];

  for (String line in file) {
    if (previous.length < 3) {
      previous.add(int.parse(line));
    } else {
      int sumPrev = previous[0] + previous[1] + previous[2];
      int sumNow = previous[1] + previous[2] + int.parse(line);
      if (sumPrev < sumNow) increses++;
      previous.removeAt(0);
      previous.add(int.parse(line));
    }
  }

  print(increses);
}
