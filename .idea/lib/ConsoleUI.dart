import 'dart:io';

class ConsoleUI {

  promptServer() {
    stdout.write('Enter the server URL [default: 0] ');

    var url = stdin.readLineSync();
    return url;
  }

  promptstrategy(strategies) {
    stdout.write('Select the server strategy: 1. ${strategies[0]} 2. ${strategies[1]} [default: 1] ');

    var line = stdin.readLineSync();

    try {
      var selection = int.parse(line);

      switch(selection) {
        case 1:
          stdout.write('Selected strategy: ' + strategies[0]);
          return strategies[0];
          break;
        case 2:
          stdout.write('Selected strategy: ' + strategies[1]);
          return strategies[1];
          break;
        default:
          stdout.write('Invalid selection: ${selection}');
          break;
      }
    } on FormatException {
      stdout.write('Format Error!');
    }

    return strategies[0];
  }
}