import 'dart:collection';
import 'dart:io';

void main() async {
  var path = '10/input.txt';
  List<String> file = await File(path).readAsLines();

  Map<String, String> chunkBrackets = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
  };

  List<String> wrongBrackets = [];

  for (var line in file) {
    List<String> chunkCharacters = line.split('');
    Queue<String> openedChunks = Queue();

    for (var bracket in chunkCharacters) {
      if (chunkBrackets.keys.contains(bracket)) {
        openedChunks.add(bracket);
      } else if (chunkBrackets.values.contains(bracket)) {
        if (chunkBrackets[openedChunks.last] == bracket) {
          openedChunks.removeLast();
        } else {
          wrongBrackets.add(bracket);
          break;
        }
      }
    }
  }

  int _bracketToScore(String bracket) {
    switch (bracket) {
      case ')':
        return 3;
      case ']':
        return 57;
      case '}':
        return 1197;
      case '>':
        return 25137;
      default:
        return 0;
    }
  }

  int _calculateSyntaxErrorScore() => wrongBrackets.fold(
      0, (previousValue, element) => previousValue += _bracketToScore(element));

  print(_calculateSyntaxErrorScore());
}
