import 'dart:io';

void main() async {
  var path = '9/input.txt';
  List<String> file = await File(path).readAsLines();

  List<List<int>> map =
      file.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();

  List<int> lowPoints = [];

  for (var i = 0; i < map.length; i++) {
    for (var j = 0; j < map[i].length; j++) {
      List<int> neighbors = [];
      if (i - 1 >= 0) neighbors.add(map[i - 1][j]);
      if (i + 1 < map.length) neighbors.add(map[i + 1][j]);
      if (j - 1 >= 0) neighbors.add(map[i][j - 1]);
      if (j + 1 < map[i].length) neighbors.add(map[i][j + 1]);
      if (!neighbors.any((element) => map[i][j] >= element))
        lowPoints.add(map[i][j]);
    }
  }

  int sum =
      lowPoints.fold(0, (previousValue, element) => previousValue += element) +
          lowPoints.length;

  print(sum);
}
