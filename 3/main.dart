import 'dart:io';

void main(List<String> args) async {
  var input = '3/.txt';

  List<String> file = await File(input).readAsLines();

  List<int> ones = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> zeros = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  for (String line in file) {
    for (int i = 0; i < line.length; i++) {
      if (line[i] == '0')
        zeros[i]++;
      else
        ones[i]++;
    }
  }

  String gammaStr = '';
  String epsilonStr = '';

  for (int i = 0; i < ones.length; i++) {
    if (ones[i] > zeros[i]) {
      gammaStr += '1';
      epsilonStr += '0';
    } else {
      gammaStr += '0';
      epsilonStr += '1';
    }
  }

  int gamma = int.parse(gammaStr, radix: 2);
  int epsilon = int.parse(epsilonStr, radix: 2);

  print(gamma * epsilon);
}
