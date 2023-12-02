import 'dart:io';

import 'board.dart';

void main(List<String> args) async {
  var input = '4/.txt';

  List<String> file = await File(input).readAsLines();

  late List<int> order;

  bool isOrder = true;
  List<String> buff = [];
  List<Board> boards = [];

  for (String line in file) {
    if (isOrder) {
      isOrder = false;
      order = line.split(',').map((number) => int.parse(number)).toList();
    } else {
      if (line.isEmpty && buff.isNotEmpty) {
        List<List<int>> boardBuff = buff.map((row) {
          row = row.trim();
          return row
              .split(new RegExp('\\s+'))
              .toList()
              .map((num) => int.parse(num))
              .toList();
        }).toList();
        boards.add(Board(boardBuff));
        buff = [];
      } else if (line.isNotEmpty && line != 'end') {
        buff.add(line);
      }
    }
  }

  bool bingo = false;

  for (int number in order) {
    // if (!bingo)
    List<int> ids = [];
    for (Board board in boards) {
      if (board.checkBingo(number)) {
        print(board.calculateBingo() * number);
        bingo = true;
        ids.add(boards.indexOf(board));
      }
    }
    for (int i = 0; i < ids.length; i++) boards.removeAt(ids[i] - i);
  }
}
