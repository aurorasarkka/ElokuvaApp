import 'package:flutter/material.dart';
import 'package:movie_thing/api/endpoints.dart';
import 'package:movie_thing/models/genres.dart';
import 'package:movie_thing/screens/widgets.dart';

class GenreMovies extends StatelessWidget {
  final ThemeData themeData;
  final Genres genre;
  final List<Genres> genres;

  const GenreMovies(
      {super.key, required this.themeData, required this.genre, required this.genres});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.primaryColor,
        title: Text(
          genre.name!,
          style: themeData.textTheme.headlineSmall,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ParticularGenreMovies(
        themeData: themeData,
        api: Endpoints.getMoviesForGenre(genre.id!, 1),
        genres: genres,
      ),
    );
  }
}
