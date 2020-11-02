import 'dart:convert';

class ResponseParser {
  var _info;

  ResponseParser(info) {
    this._info = info;
  }

  Map<String, dynamic> parseInfo() {
    return json.decode(_info.body);
  }
}