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