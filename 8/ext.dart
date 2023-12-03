import 'dart:io';

void main() async {
  var path = '8/input.txt';
  List<String> file = await File(path).readAsLines();
  List<List<String>> paterns = [];
  List<List<String>> outputs = [];

  for (var line in file) {
    var splitLine = line.split('|');
    paterns.add(splitLine.first.split(' '));
    outputs.add(splitLine.last.split(' '));
  }

  int sum = 0;

  for (var i = 0; i < paterns.length; i++) {
    Patern patern = Patern.fromPaterns(paterns[i]);
    String number = '';
    outputs[i].forEach((element) => number += patern.getNumber(element));
    sum += int.parse(number);
  }

  print(sum);
}

class Patern {
  String? a, b, c, d, e, f, g;

  Patern({this.a, this.b, this.c, this.d, this.e, this.f, this.g});

  factory Patern.fromPaterns(List<String> paterns) {
    Patern patern = Patern();
    patern.fillPatern(paterns);
    return patern;
  }

  fillPatern(List<String> paterns) {
    String one = paterns.firstWhere((element) => element.length == 2);
    String four = paterns.firstWhere((element) => element.length == 4);
    String seven = paterns.firstWhere((element) => element.length == 3);
    String eight = paterns.firstWhere((element) => element.length == 7);

    Set<String> oneSet = one.split('').toSet();
    Set<String> fourSet = four.split('').toSet();
    Set<String> sevenSet = seven.split('').toSet();

    a = seven.replaceAll(RegExp('[$one]'), '');
    g = paterns
        .firstWhere((element) =>
            element.split('').toSet().containsAll([...fourSet, a]) &&
            element.length == 6)
        .replaceAll(RegExp('[$four$a]'), '');
    e = eight.replaceAll(RegExp('[$four$a$g]'), '');
    d = paterns
        .firstWhere((element) =>
            element.split('').toSet().containsAll([...sevenSet, g]) &&
            element.length == 5)
        .replaceAll(RegExp('[$seven$g]'), '');
    b = paterns
        .firstWhere((element) =>
            element.split('').toSet().containsAll([a, e, g, ...oneSet]) &&
            element.length == 6)
        .replaceAll(RegExp('[$one$a$e$g]'), '');
    f = paterns
        .firstWhere((element) =>
            element.split('').toSet().containsAll([a, b, d, g]) &&
            element.length == 5)
        .replaceAll(RegExp('[$a$b$d$g]'), '');
    c = eight.replaceAll(RegExp('[$a$b$d$e$f$g]'), '');
  }

  String getNumber(String number) {
    bool cA, cB, cC, cD, cE, cF, cG;
    cA = number.contains(a!);
    cB = number.contains(b!);
    cC = number.contains(c!);
    cD = number.contains(d!);
    cE = number.contains(e!);
    cF = number.contains(f!);
    cG = number.contains(g!);
    if (cA && cB && cC && cD && cE && cF && cG) {
      return '8';
    } else if (cA && cB && cD && cE && cF && cG) {
      return '6';
    } else if (cA && cB && cC && cE && cF && cG) {
      return '0';
    } else if (cA && cB && cC && cD && cF && cG) {
      return '9';
    } else if (cA && cB && cD && cF && cG) {
      return '5';
    } else if (cA && cC && cD && cE && cG) {
      return '2';
    } else if (cA && cC && cD && cF && cG) {
      return '3';
    } else if (cB && cC && cD && cF) {
      return '4';
    } else if (cA && cC && cF) {
      return '7';
    } else if (cC && cF) {
      return '1';
    }
    return '';
  }
}
