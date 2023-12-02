import 'dart:io';

void main(List<String> args) async {
  var input = '3/.txt';

  List<String> file = await File(input).readAsLines();

  int listLength = file[0].length;

  List<int> ones = List.generate(listLength, (index) => 0);
  List<int> zeros = List.generate(listLength, (index) => 0);
  late int gamma;
  late int epsilon;
  int oxygen = 0;
  int CO2 = 0;

  _calculateEpsyGamma() {
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

    gamma = int.parse(gammaStr, radix: 2);
    epsilon = int.parse(epsilonStr, radix: 2);
  }

  _calculateOxy() {
    List<String> oxygenList = [...file];
    for (int i = 0; i < listLength; i++) {
      if (oxygenList.length == 1) break;
      int ones = 0;
      int zeros = 0;
      for (String line in oxygenList) {
        line[i] == '0' ? zeros++ : ones++;
      }

      if (ones >= zeros)
        oxygenList.removeWhere((element) => element[i] == '0');
      else
        oxygenList.removeWhere((element) => element[i] == '1');
    }
    oxygen = int.parse(oxygenList.first, radix: 2);
  }

  _calculateCo2() {
    List<String> CO2List = [...file];
    for (int i = 0; i < listLength; i++) {
      if (CO2List.length == 1) break;
      int ones = 0;
      int zeros = 0;
      for (String line in CO2List) {
        line[i] == '0' ? zeros++ : ones++;
      }

      if (ones >= zeros)
        CO2List.removeWhere((element) => element[i] == '1');
      else
        CO2List.removeWhere((element) => element[i] == '0');
    }
    CO2 = int.parse(CO2List.first, radix: 2);
  }

  _calculateEpsyGamma();
  _calculateCo2();
  _calculateOxy();
  int lifeSupport = oxygen * CO2;
  print('Life support: ' + lifeSupport.toString());

  print(gamma * epsilon);
}
