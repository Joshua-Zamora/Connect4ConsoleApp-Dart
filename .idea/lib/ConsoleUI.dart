import 'dart:io';
import 'Model.dart';

class ConsoleUI {

  Board _board;

  void setBoard(Board board) {
    this._board = board;
  }

  void showMessage(String message) {
    print(message);
  }

  void showBoard(int lastMove) {
    for(int i = 0; i < _board.height; i++) {
      for(int j = 0; j < _board.width; j++) {
        stdout.write(_board.getBoardSlots()[i][j].getSymbol() + ' ');
      }
      print('');
    }
    for(int i = 1; i <= _board.width; i++) {
      stdout.write(i.toString() + ' ');
    }
    print(' ');
    if(lastMove >= 0) {
      var marker = new List<String>.filled(_board.width, ' ', growable:false);
      marker[lastMove] = '*';
      print(marker.join(' '));
    }
  }

  String promptServer(String defaultURL) {
    while (true) {
      stdout.write('Enter the server URL [default: $defaultURL] ');
      var url = stdin.readLineSync();
      if (url.isEmpty) {
        return defaultURL;
      }
      else if (Uri
          .parse(url)
          .isAbsolute) {
        return url;
      }
      showMessage('Invalid URL: $url');
    }
  }

  String promptStrategy(List strategies) {
    while (true) {
      stdout.write('Select the server strategy:');
      for (var i = 0; i < strategies.length; i++) {
        stdout.write(' ${i + 1}. ${strategies[i]}');
      }
      stdout.write(' [default: 1]');
      var line = stdin.readLineSync();
      try {
        if (line.isEmpty) {
          return strategies[0];
        }
        var selection = int.parse(line);
        if (selection >= 1 && selection <= strategies.length) {
          return strategies[selection - 1];
        }
      } on FormatException {
      }
      showMessage('Invalid selection: $line');
    }
  }
}