import 'dart:async';
import 'dart:convert';

import 'package:cartelera/src/models/movie_model.dart';
import 'package:cartelera/src/models/performer_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apikey = '9afdf82740163cc2b417931773f1bea4';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularPage = 0;
  bool _isLoading = false;

  List<Movie> _popular = new List();

  // Definimos stream privado y dos funciones getter para añadir y leer datos del stream
  final _popularStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  // Cierra los streams existentes al cerrar el widget
  void disposeStreams() {
    _popularStreamController?.close();
  }

  // Método privado que procesa las respuestas de películas
  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final data = json.decode(response.body);
    final movies = new Movies.fromJsonList(data['results']);

    return movies.items;
  }

  // Obtiene las películas que están ahora en cartelera
  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _processResponse(url);
  }

  // Obtiene las películas más populares
  Future<List<Movie>> getPopular() async {
    // Previene la repetición de la petición si ya hay una en curso
    if (_isLoading) return [];

    // Indica que estamos cargando datos
    _isLoading = true;

    // Cargamos la siguiente página
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString(),
    });

    final resp = await _processResponse(url);

    _popular.addAll(resp);
    popularSink(_popular);

    // Actualiza el estado de cargando datos
    _isLoading = false;

    return resp;
  }

  // Obtiene la lista de actores de una pelicula
  Future<List<Performer>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final data = json.decode(resp.body);

    final cast = new Cast.fromJsonList(data['cast']);

    return cast.performers;
  }
}
