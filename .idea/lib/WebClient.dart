import 'ResponseParser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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

class Result<T> {

  final T value;

  final String error;

  Result(this.value, [this.error]);

  Result.value(T value): this(value);

  Result.error(String error): this(null, error);

  bool get isValue => value != null;

  bool get isError => error != null;
}

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