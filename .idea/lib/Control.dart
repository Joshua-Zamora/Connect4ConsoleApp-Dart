import 'View.dart';
import 'Model.dart';
import 'dart:io';

class Controller {
  ConsoleUI _console;
  WebClient _client;

  Controller() {
    this._console = new ConsoleUI();
    this._client = new WebClient();
  }

  void requestGame() async {
    _client.url = _console.promptServer(_client.DEFAULT_URL);

    print("Obtaining server information ......");

    _playGame(await _client.createGame(_console.promptStrategy(await _client.getStrategies())));
  }

  void _playGame(var pid) async {
      _console.printBoard();

      stdout.write("Enter a move (0-6): ");

      var move = stdin.readLineSync();

      if (move == null || (double.parse(move, (e) => null) == null) ||
         (double.parse(move) < 0 || double.parse(move) > 6)) {
        print("Invalid Move: " + move);
        _playGame(pid);
        return;
      }

      var response = await _client.playMove(pid, move);

      _console.insertDisc(int.parse(response['ack_move']['slot'].toString()), 1);

      if (_endGame(response) == true) return;

      _console.insertDisc(int.parse(response['move']['slot'].toString()), 2);

      if (_endGame(response) == false) _playGame(pid);
  }

  bool _endGame(var response) {
    if (response['ack_move']['isWin'] == true) {
      _console.printBoard();

      print("You Won!");
      print("Winning Row: " + response['ack_move']['row'].toString());
      return true;
    }
    else if (response['move']['isWin'] == true) {
      _console.printBoard();

      print("You lost!");
      print("Winning Row: " + response['move']['row'].toString());
      return true;
    }
    else if(response['move']['isDraw'] == true) {
      _console.printBoard();

      print("No more slots, You Drawn!");
      return true;
    }
    else return false;
  }
}
