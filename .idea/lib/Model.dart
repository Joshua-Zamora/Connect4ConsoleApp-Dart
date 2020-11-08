import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WebClient {
  final DEFAULT_URL = "http://www.cs.utep.edu/cheon/cs3360/project/c4";
  final INFO = "/info/";
  final NEW = "/new/";
  final PLAY = "/play/";

  var url;

  WebClient() {}

  Future<List<dynamic>> getStrategies() async {
    final response = await http.get(url + INFO);

    if (response.statusCode == 200) return jsonDecode(response.body)['strategies'];
    else throw Exception("Failed to connect to server!");
  }

  Future<String> createGame(var strategy) async {
    final response = await http.get(url + NEW + "?strategy=" + strategy);

    if (response.statusCode == 200) return jsonDecode(response.body)['pid'];
    else throw Exception("Failed to connect to server!");
  }

  Future<Map<String, dynamic>> playMove(String pid, String move) async {
    final response  = await http.get(url + PLAY + "?pid=" + pid + "&move=" + move);

    if (response.statusCode == 200) return jsonDecode(response.body);
    else throw Exception("Failed to connect to server!");
  }
}


