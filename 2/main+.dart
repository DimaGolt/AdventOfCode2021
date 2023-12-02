import 'dart:io';

void main(List<String> args) async {
  var input = '2/.txt';

  List<String> file = await File(input).readAsLines();

  int depth = 0;
  int width = 0;
  int aim = 0;

  for (String line in file) {
    List<String> command = line.split(' ');
    switch (command[0]) {
      case 'forward':
        width += int.parse(command[1]);
        depth += aim * int.parse(command[1]);
        break;
      case 'down':
        aim += int.parse(command[1]);
        break;
      case 'up':
        aim -= int.parse(command[1]);
        break;
      default:
    }
  }

  print(depth * width);
}
