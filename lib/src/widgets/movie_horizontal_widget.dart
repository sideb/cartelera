import 'package:cartelera/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {
  // Listado de películas a mostrar
  final List<Movie> movies;
  // Referencia al método a llamar para cargar más paginas
  final Function nextPage;

  // Controller de páginas
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  //Constructor
  MovieHorizontal({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      // Cargamos la siguiente página 200 pixeles antes del final del scroll
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    // Contenedor principal del widget
    return Container(
      height: _screenSize.height * 0.2, // Este elemento ocupa el 20% del alto
      child: PageView(
        pageSnapping: true,
        controller: _pageController,
        children: _cards(context),
      ),
    );
  }

  // Widget que devuelve lista de las tarjetas de películas
  List<Widget> _cards(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return movies.map((movie) {
      return Container(
        //margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImg()),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.17,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
