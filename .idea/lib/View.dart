import 'dart:io';

class ConsoleUI {
  List<List<int>> _board;

  ConsoleUI() {
    this._board = List<List<int>>.generate(6, (i) =>
    List<int>.generate(7, (i) => 0, growable: false), growable: false);

  }

  void insertDisc(int move, int player) {
    for (int yCoordinate = 5; yCoordinate > -1; yCoordinate--) {
      if (_board[yCoordinate][move] == 0) {
        _board[yCoordinate][move] = player;
        return;
      }
    }
  }

  void printBoard() {
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 7; j++) {
        if (_board[i][j] == 0) stdout.write('. ');
        else if (_board[i][j] == 1) stdout.write('O ');
        else stdout.write('X ');
      }
        print('');
    }
  }

  void printComputerMove(int computerMove) {
    for(int i = 1; i <= 7; i++) {
      stdout.write(i.toString() + ' ');
    }
    print('');

    if(computerMove >= 0) {
      var marker = new List<String>.filled(7, ' ', growable:false);
      marker[computerMove] = '*';
      print(marker.join(' '));
    }
  }

  void printWinnningRow(List<dynamic> row) {
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 7; j++) {
        if (j == row[0] && i == row[1]) stdout.write('W ');
        else if (j == row[2] && i == row[3]) stdout.write('W ');
        else if (j == row[4] && i == row[5]) stdout.write('W ');
        else if (j == row[6] && i == row[7]) stdout.write('W ');
        else if (_board[i][j] == 0) stdout.write('. ');
        else if (_board[i][j] == 1) stdout.write('O ');
        else stdout.write('X ');
      }
      print('');
    }
  }

  String promptServer(String defaultURL) {
    while (true) {
      stdout.write('Enter the server URL [default: $defaultURL]: ');

      var url = stdin.readLineSync();

      if (url.isEmpty) return defaultURL;
      else if (Uri.parse(url).isAbsolute) return url;
      else print('Invalid URL: ' + url);
    }
  }

  String promptStrategy(var strategies) {
    while (true) {
      stdout.write('Select the server strategy: 1. ' + strategies[0] + ' 2. ' + strategies[1] + ' [default: 1]: ');

      var line = stdin.readLineSync();

      if (line.isEmpty) return strategies[0];
      switch (int.tryParse(line)) {
        case 1:
          print("Selected strategy: " + strategies[0]);
          return strategies[0];
        case 2:
          print("Selected strategy: " + strategies[1]);
          return strategies[1];
      }

      print('Invalid selection: ' + line);
    }
  }
}
