import 'ResponseParser.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class WebClient {
  var _url;

  WebClient(url) {
    this._url = url;
  }

  Future<Map<String, dynamic>> getInfo() async {
    stdout.write('Obtaining server information ......\n');

    var response = await http.get(this._url);

    ResponseParser responseParser = new ResponseParser(response);
    return responseParser.parseInfo();
  }
}