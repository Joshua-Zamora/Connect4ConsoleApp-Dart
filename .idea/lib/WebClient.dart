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

  Future<Result<Map>> getInfo() async {
    var response = await http.get(this._url + this.INFO);
    var info = this._responseParser.parseInfo(response);
    return Result.value(info);
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