import 'WebClient.dart';
import 'ConsoleUI.dart';

class Controller {
  var _strategy, _info;

  void requestGame() async {
    ConsoleUI consoleUI = new ConsoleUI();

    WebClient webClient = new WebClient();

    var url = consoleUI.promptServer(webClient.DEFAULT_URL);
    consoleUI.showMessage('Obtaining server information .....');
    webClient.setURL(url);
    var result = await webClient.getInfo();
    var strategies = result.value['strategies'];
    var strategy = consoleUI.promptStrategy(strategies);
  }
}
