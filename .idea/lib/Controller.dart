import 'WebClient.dart';
import 'ConsoleUI.dart';

class Controller {
  var _strategy, _url, _info;

  void requestGame() async {
    ConsoleUI consoleUI = new ConsoleUI();
    this._url = consoleUI.promptServer();

    WebClient webClient = new WebClient(this._url);

    this._info = await webClient.getInfo();

    this._strategy = consoleUI.promptstrategy(this._info['strategies']);
  }
}
