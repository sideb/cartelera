import 'dart:convert';

import 'package:cartelera/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '9afdf82740163cc2b417931773f1bea4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // Obtiene las películas que están ahora en cartelera
  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    final response = await http.get(url);
    final data = json.decode(response.body);
    final movies = new Movies.fromJsonList(data['results']);

    return movies.items;
  }
}
