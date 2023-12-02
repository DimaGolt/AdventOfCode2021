class Board {
  late List<List<BingoNum>> board;

  Board(List<List<int>> eBoard) {
    board =
        eBoard.map((row) => row.map((num) => BingoNum(num)).toList()).toList();
  }

  bool _checkRows() {
    bool gotBingo = false;
    for (List<BingoNum> column in board) {
      if (column.every((num) => num.bingod == true)) gotBingo = true;
    }

    return gotBingo;
  }

  bool _checkColumns() {
    bool gotBingo = false;
    List<List<BingoNum>> rotatedBoard = [];
    for (int i = 0; i < board[0].length; i++) {
      rotatedBoard.add([]);
      for (int j = 0; j < board.length; j++) {
        rotatedBoard.last.add(board[j][i]);
      }
    }
    for (List<BingoNum> column in rotatedBoard) {
      if (column.every((num) => num.bingod == true)) gotBingo = true;
    }
    return gotBingo;
  }

  bool checkBingo(int num) {
    bool gotBingo = false;
    for (List<BingoNum> column in board) {
      for (BingoNum numba in column) if (numba.num == num) numba.changeState();
    }
    gotBingo = _checkRows();
    if (gotBingo != true) gotBingo = _checkColumns();
    return gotBingo;
  }

  int calculateBingo() {
    int sum = 0;

    board.forEach((row) => row.forEach((num) {
          if (!num.bingod) sum += num.num;
        }));

    return sum;
  }
}

class BingoNum {
  bool bingod = false;
  int num;

  BingoNum(this.num);

  changeState() {
    bingod = true;
  }
}
