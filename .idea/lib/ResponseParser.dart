import 'dart:convert';

class ResponseParser {

  Map<String, dynamic> parseInfo(var _info) {
    return json.decode(_info.body);
  }
}