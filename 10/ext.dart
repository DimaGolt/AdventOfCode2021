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

  List<int> autocompletionScores = [];

  // discard corrupted
  List<String> linesToRemove = [];
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
          linesToRemove.add(line);
          break;
        }
      }
    }
  }
  file.removeWhere((element) => linesToRemove.contains(element));

  int _bracketToScore(String bracket) {
    switch (bracket) {
      case '(':
        return 1;
      case '[':
        return 2;
      case '{':
        return 3;
      case '<':
        return 4;
      default:
        return 0;
    }
  }

  // complete lines
  for (var line in file) {
    List<String> chunkCharacters = line.split('');
    Queue<String> openedChunks = Queue();

    for (var bracket in chunkCharacters) {
      if (chunkBrackets.keys.contains(bracket)) {
        openedChunks.addFirst(bracket);
      } else {
        openedChunks.removeFirst();
      }
    }

    int score = 0;
    for (var bracket in openedChunks) {
      score *= 5;
      score += _bracketToScore(bracket);
    }
    autocompletionScores.add(score);
  }

  autocompletionScores.sort();

  print(autocompletionScores[(autocompletionScores.length / 2).floor()]);
}
