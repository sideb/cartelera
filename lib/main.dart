import 'package:cartelera/src/pages/home_page.dart';
import 'package:cartelera/src/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cartelera',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'movie_detail': (BuildContext context) => MovieDetail(),
      },
    );
  }
}
