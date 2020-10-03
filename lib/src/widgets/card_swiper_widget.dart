import 'package:cartelera/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  // Constructor
  CardSwipper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    // Local Variables
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: _screenSize.width,
      height: _screenSize.height * 0.5,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _movieCard(context, movies[index]);
        },
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }

  ///
  /// widget con el poster de cada película y enlace a detalle de la misma
  ///
  Widget _movieCard(BuildContext context, Movie movie) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        placeholder: AssetImage('assets/img/no-image.jpg'),
        image: NetworkImage(movie.getPosterImg()),
        fit: BoxFit.cover,
      ),
    );

    // A la tarjeta se le añade enlace a detalles de la película
    return GestureDetector(
      child: card,
      onTap: () {
        //print('Película: ${movie.title}');
        Navigator.pushNamed(context, 'movie_detail', arguments: movie);
      },
    );
  }
}
