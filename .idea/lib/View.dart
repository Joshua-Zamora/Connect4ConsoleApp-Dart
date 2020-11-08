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

  void printBoard(int lastMove) {
    for(int i = 0; i < 6; i++) {
      for(int j = 0; j < 7; j++) {
        if (_board[i][j] == 0) stdout.write('. ');
        else if (_board[i][j] == 1) stdout.write('O ');
        else stdout.write('X ');
      }
        print('');
    }
    for(int i = 1; i <= 7; i++) {
      stdout.write(i.toString() + ' ');
    }
    print('');
    if(lastMove >= 0) {
      var marker = new List<String>.filled(6, ' ', growable:false);
      marker[lastMove] = '*';
      print(marker.join(' '));
    }
  }

  String promptServer(String defaultURL) {
    while (true) {
      stdout.write('Enter the server URL [default: $defaultURL] ');

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
      try {
        switch (int.parse(line)) {
          case 1:
            print("Selected strategy: " + strategies[0]);
            return strategies[0];
          case 2:
            print("Selected strategy: " + strategies[1]);
            return strategies[1];
          default:
            break;
        }
      } on Exception {
      }
      print('Invalid selection: ' + line);
    }
  }
}
