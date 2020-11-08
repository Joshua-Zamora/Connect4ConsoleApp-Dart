import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

/** Player */
class Player {

  String _symbol;

  Player(String symbol) {
    this._symbol = symbol;
  }

  String getSymbol() {
    return this._symbol;
  }

}
/** Board */
class Board {

  int width;
  int height;

  List<List<Player>> _boardSlots;

  Player _emptySlots;
  Player _winnerSlots;

  Board(int width, int height) {
    this.width = width;
    this.height = height;
    this._emptySlots = new Player('_');
    this._winnerSlots = new Player('W');
    this._boardSlots = List.generate(height, (i) => List(width), growable: false);
    for(int i = 0; i < height; i++) {
      for(int j = 0; j < width; j++) {
        this._boardSlots[i][j] = this._emptySlots;
      }
    }
  }

  List<List<Player>>getBoardSlots() {
    return _boardSlots;
  }

}
/** Web-Client */
class WebClient {

  final DEFAULT_URL = 'https://cssrvlab01.utep.edu/classes/cs3360/jazamora6';
  final INFO = '/info/';
  final NEW = '/new/';
  final PLAY = '/play/';

  var _url;
  var _responseParser;

  WebClient() {
    this._responseParser = new ResponseParser();
  }

  void setURL(String url) {
    this._url = url;
  }

  Future<Result<Info>> getInfo() async {
    var response = await http.get(_url + INFO);
    if(response.statusCode == 200) {
      var info = _responseParser.parseInfo(response);
      if(info.isValue) {
        return Result.value(info.value);
      }
      return Result.error(info.error);
    }
    return Result.error('Failed to connect with server.');
  }

  Future<Result<String>> createGame(String strategy) async {
    var response = await http.get(_url + NEW + '?strategy=' + strategy);
    if(response.statusCode == 200) {
      var newgame = _responseParser.parseNew(response);
      if(newgame.isValue) {
        return Result.value(newgame.value);
      }
      return Result.error(newgame.error);
    }
    return Result.error('Failed to connect with server.');
  }
}

/** Result */
class Result<T> {

  final T value;

  final String error;

  Result(this.value, [this.error]);

  Result.value(T value): this(value);

  Result.error(String error): this(null, error);

  bool get isValue => value != null;

  bool get isError => error != null;
}

/** Info */
class Info {

  int width;
  int height;
  List strategies;

  Info(int width, int height, List strategies) {
    this.width = width;
    this.height = height;
    this.strategies = strategies;
  }

}

/** Response Parser */
class ResponseParser {

  Result<Info> parseInfo(var response) {
    try {
      var jsonContent = json.decode(response.body);
      if(!jsonContent.isEmpty) {
        int width = jsonContent['width'];
        int height = jsonContent['height'];
        List strategies = jsonContent['strategies'];
        Info info = new Info(width, height, strategies);
        return Result.value(info);
      }
    } on FormatException {
    }
    return Result.error('Information in wrong format.');
  }

  Result<String> parseNew(var response) {
    var jsonContent =json.decode(response.body);
    if(!jsonContent.isEmpty) {
      try {
        response = jsonContent['response'];
        if (response) {
          var pid = jsonContent['pid'];
          return Result.value(pid);
        }
        var reason = jsonContent['reason'];
        return Result.error(reason);
      } on Exception {
      }
    }
    return Result.error('Information in wrong format.');
  }

}
