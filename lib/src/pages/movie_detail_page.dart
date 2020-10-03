import 'package:cartelera/src/models/movie_model.dart';
import 'package:cartelera/src/models/performer_model.dart';
import 'package:cartelera/src/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Película enviada en los argumentos de la llamada
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      // Colección de elementos
      slivers: <Widget>[
        _renderAppbar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _titlePoster(context, movie),
          _description(context, movie),
          _casting(context, movie),
        ])),
      ],
    ));
  }

  // Pinta la cabecera con el titulo y la imagen de backdrop
  Widget _renderAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(movie.geBackdropImg()),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2)
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _casting(BuildContext context, Movie movie) {
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
        future: moviesProvider.getCast(movie.id.toString()),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return _makeCastPageView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _makeCastPageView(List<Performer> performers) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: performers.length,
        itemBuilder: (context, i) {
          return _performerCard(performers[i]);
        },
      ),
    );
  }

  Widget _performerCard(Performer performer) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(performer.getProfileImg()),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          Text(
            performer.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
