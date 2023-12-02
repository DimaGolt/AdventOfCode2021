import 'dart:io';

void main() async {
  var path = '6/input.txt';
  String file = await File(path).readAsString();
  List<String> fishesInStr = file.split(',');
  List<Lanterfish> fishes = List.generate(9, (index) => Lanterfish(day: index));

  for (var str in fishesInStr) {
    int index = int.parse(str);
    fishes[index].count += 1;
  }

  int days = 256;

  for (var i = 0; i < days; i++) {
    List<Move> moves = [];
    fishes.forEach((element) => moves.add(element.live()));
    moves.forEach((element) => fishes[element.where].count += element.howMany);
    int? newFishCount = moves
        .cast<Move?>()
        .firstWhere(
          (element) => element?.where == 8,
          orElse: () => null,
        )
        ?.howMany;
    fishes[6].count += newFishCount ?? 0;
  }

  print(fishes.fold<int>(
      0, (previousValue, element) => previousValue += element.count));
}

class Lanterfish {
  int day;
  int count;

  Lanterfish({required this.day, this.count = 0});

  Move live() {
    Move result;
    if (count != 0) {
      if (day == 0) {
        result = Move(count, 8);
        count = 0;
      } else {
        result = Move(count, day - 1);
        count = 0;
      }
    } else {
      result = Move(0, 0);
    }
    return result;
  }

  @override
  String toString() {
    return 'Day $day with $count';
  }
}

class Move {
  int howMany, where;

  Move(this.howMany, this.where);
}
