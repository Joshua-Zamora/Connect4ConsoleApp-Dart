import 'dart:convert';
import 'WebClient.dart';

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

}