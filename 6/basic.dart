import 'dart:io';

void main() async {
  var path = '6/input.txt';
  String file = await File(path).readAsString();
  List<Lanterfish> fishes =
      file.split(',').map((e) => Lanterfish(day: int.parse(e))).toList();

  int days = 80;

  for (var i = 0; i < days; i++) {
    List<Lanterfish> fishesToAdd = [];
    fishes.forEach(
        (element) => element.live(() => fishesToAdd.add(Lanterfish(day: 8))));
    fishes.addAll(fishesToAdd);
  }

  print(fishes.length);
}

class Lanterfish {
  int day;

  Lanterfish({required this.day});

  live(Function() onEnd) {
    if (day == 0) {
      onEnd();
      day = 6;
    } else {
      day--;
    }
  }
}
