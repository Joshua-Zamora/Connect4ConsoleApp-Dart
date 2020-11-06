import 'dart:io';

class ConsoleUI {

  void showMessage(String message) {
    print(message);
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