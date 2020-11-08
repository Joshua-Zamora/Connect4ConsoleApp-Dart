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

  static int _computerMove = -1;

  void _playGame(var pid) async {
      _console.printBoard(_computerMove);

      stdout.write("Enter a move (1-7): ");

      var move = stdin.readLineSync();

      if (move == null || (int.tryParse(move) == null) ||
         (int.parse(move) < 1 || int.parse(move) > 7)) {
        print("Invalid Move: " + move);
        _playGame(pid);
        return;
      }

      move = (int.parse(move) - 1).toString();

      var response = await _client.playMove(pid, move);

      _console.insertDisc(int.parse(response['ack_move']['slot'].toString()), 1);

      if (_endGame(response) == true) return;

      _console.insertDisc(int.parse(response['move']['slot'].toString()), 2);
      _computerMove = response['move']['slot'];

      if (_endGame(response) == false) _playGame(pid);
  }

  bool _endGame(var response) {
    if (response['ack_move']['isWin'] == true) {
      _console.printBoard(-1);

      print("You Won!");
      print("Winning Row: " + response['ack_move']['row'].toString());
      return true;
    }
    else if (response['move']['isWin'] == true) {
      _computerMove = response['move']['slot'];
      _console.insertDisc(int.parse(response['move']['slot'].toString()), 2);
      _console.printBoard(_computerMove);

      print("You lost!");
      print("Winning Row: " + response['move']['row'].toString());
      return true;
    }
    else if(response['move']['isDraw'] == true) {
      _console.printBoard(_computerMove);

      print("No more slots, You Drawn!");
      return true;
    }
    else return false;
  }
}
