import 'dart:io';

void main() async {
  var path = '9/input.txt';
  List<String> file = await File(path).readAsLines();

  List<List<int>> map =
      file.map((e) => e.split('').map((e) => int.parse(e)).toList()).toList();

  List<Point> lowPoints = [];

  for (var i = 0; i < map.length; i++) {
    for (var j = 0; j < map[i].length; j++) {
      List<int> neighbors = [];
      if (i - 1 >= 0) neighbors.add(map[i - 1][j]);
      if (i + 1 < map.length) neighbors.add(map[i + 1][j]);
      if (j - 1 >= 0) neighbors.add(map[i][j - 1]);
      if (j + 1 < map[i].length) neighbors.add(map[i][j + 1]);
      if (!neighbors.any((element) => map[i][j] >= element))
        lowPoints.add(Point(i: i, j: j, value: map[i][j]));
    }
  }

  List<Basin> basins = lowPoints.map((e) => Basin()..locations.add(e)).toList();

  for (var basin in basins) {
    bool noMore = false;
    while (!noMore) {
      noMore = true;
      Set<Point> toAdd = {};
      for (var point in basin.locations) {
        List<Point> neighbors = [];
        if (point.i - 1 >= 0)
          neighbors.add(Point(
              i: point.i - 1, j: point.j, value: map[point.i - 1][point.j]));
        if (point.i + 1 < map.length)
          neighbors.add(Point(
              i: point.i + 1, j: point.j, value: map[point.i + 1][point.j]));
        if (point.j - 1 >= 0)
          neighbors.add(Point(
              i: point.i, j: point.j - 1, value: map[point.i][point.j - 1]));
        if (point.j + 1 < map[point.i].length)
          neighbors.add(Point(
              i: point.i, j: point.j + 1, value: map[point.i][point.j + 1]));
        neighbors.forEach((element) {
          if (element.value > point.value &&
              element.value != 9 &&
              !basin.locations.contains(element)) {
            toAdd.add(element);
            noMore = false;
          }
        });
      }
      basin.locations.addAll(toAdd);
    }
  }

  basins.sort((a, b) => b.size.compareTo(a.size));

  print(basins
      .take(3)
      .fold<int>(1, (previousValue, element) => previousValue *= element.size));
}

class Point {
  int value;
  int i;
  int j;

  Point({required this.i, required this.j, required this.value});

  @override
  String toString() {
    return '$value: $i,$j';
  }

  @override
  operator ==(Object other) =>
      other is Point && i == other.i && j == other.j && value == other.value;

  @override
  int get hashCode => value.hashCode * i.hashCode * j.hashCode;
}

class Basin {
  Set<Point> locations = {};

  int get size => locations.length;
}
