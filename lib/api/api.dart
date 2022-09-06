import 'dart:convert';

import 'package:http/http.dart' as http;

class API {

  Future<Map> getJson(String category) async {
    var url =
        'https://api.themoviedb.org/3/movie/$category?api_key=12db7022e82fd84755282e23d2ea8480&language=en-US&page=1';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Failed to get Data");
    }
  }
}
