import 'WebClient.dart';
import 'ConsoleUI.dart';
import 'Model.dart';

class Controller {

  Board _board;
  Player _player;
  Player _opponent;

  ConsoleUI _consoleUI;
  WebClient _webClient;

  Controller() {
    this._player = new Player('O');
    this._opponent = new Player('X');
    this._consoleUI = new ConsoleUI();
    this._webClient = new WebClient();
  }

  void requestGame() async {
    _consoleUI.showMessage('Welcome to Connect Four Game');
    var url = _consoleUI.promptServer(_webClient.DEFAULT_URL);
    _consoleUI.showMessage('Obtaining server information .....');
    _webClient.setURL(url);
    dynamic result = await _webClient.getInfo();
    if(result.isError) {
      _consoleUI.showMessage(result.error);
      return;
    }
    var strategies = result.value.strategies;
    var width = result.value.width;
    var height = result.value.height;
    _board = new Board(width, height);
    _consoleUI.setBoard(_board);
    var strategy = _consoleUI.promptStrategy(strategies);
    _consoleUI.showMessage('Creating a new game .....');
    result = await _webClient.createGame(strategy);
    if(result.isError) {
      _consoleUI.showMessage(result.error);
      return;
    }
    var pid = result.value;
    playGame(pid);
  }

  void playGame(String pid) {

  }
}
