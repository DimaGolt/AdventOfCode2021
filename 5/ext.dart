import 'dart:io';

void main() async {
  var path = '5/input.txt';
  List<String> fileLines = await File(path).readAsLines();
  List<Line> lines = fileLines.map((e) => Line.fromLine(e)).toList();
  // lines = lines.removeNotLined();
  Pair mapSize = lines.getMapSize();
  List<List<int>> map = List.generate(
      mapSize.second, (_) => List.generate(mapSize.first, (_) => 0));

  for (var line in lines) {
    List<Pair<int>> pointBetween = line.pointBetween();
    for (var pair in pointBetween) {
      map[pair.second][pair.first] += 1;
    }
  }

  int sum = 0;

  for (var column in map) {
    for (var element in column) {
      if (element >= 2) sum++;
    }
  }
  print(sum);
}

class Line {
  Pair<int> start;
  Pair<int> end;

  Line({required this.start, required this.end});

  List<Pair<int>> pointBetween() {
    List<Pair<int>> result = [];
    int xStep = 0, yStep = 0;
    if (start.second != end.second)
      yStep = (end.second - start.second) ~/ (end.second - start.second).abs();
    if (start.first != end.first)
      xStep = (end.first - start.first) ~/ (end.first - start.first).abs();
    // int yStep = end.second - start.second;

    result.add(start);
    while (result.last.first != end.first || result.last.second != end.second) {
      result.add(Pair(
          first: result.last.first + xStep,
          second: result.last.second + yStep));
    }
    return result;
  }

  factory Line.fromLine(String line) {
    var foo = line.split('->');
    String startStr = foo.first;
    String endStr = foo.last;
    Pair<int> start = Pair(
        first: int.parse(startStr.split(',').first),
        second: int.parse(startStr.split(',').last));
    Pair<int> end = Pair(
        first: int.parse(endStr.split(',').first),
        second: int.parse(endStr.split(',').last));
    return Line(start: start, end: end);
  }

  @override
  String toString() {
    return '${start.first},${start.second} -> ${end.first},${end.second}';
  }
}

extension on List<Line> {
  List<Line> removeNotLined() {
    List<Line> toRemove = [];
    for (Line line in this) {
      if (line.start.first != line.end.first &&
          line.start.second != line.end.second) {
        toRemove.add(line);
      }
    }
    for (var line in toRemove) {
      this.remove(line);
    }
    return this;
  }

  Pair getMapSize() {
    int biggestX = 0, biggestY = 0;
    for (var line in this) {
      if (line.start.first > biggestX) biggestX = line.start.first;
      if (line.start.second > biggestY) biggestY = line.start.second;
      if (line.end.first > biggestX) biggestX = line.end.first;
      if (line.end.second > biggestY) biggestY = line.end.second;
    }
    return Pair(first: biggestX + 1, second: biggestY + 1);
  }
}

class Pair<T> {
  T first;
  T second;

  Pair({required this.first, required this.second});

  @override
  String toString() {
    return '$first,$second';
  }
}
