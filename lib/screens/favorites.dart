// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:movie_thing/screens/movie_detail.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/movieManager.dart';



class FavoritesPage extends StatelessWidget {
  final List<Movie> favorites;
  final Map<int, String> genres;

  const FavoritesPage({
    Key? key,
    required this.favorites,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieManager>(
      builder: (context, movieManager, child) {
        final List<Movie> favoriteMovies = movieManager.favorites;

        // print the list of favorite movies to the debug console
        print(favoriteMovies);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favorites',
              style: TextStyle(
                color: Color.fromRGBO(99, 227, 227, 1),
              ),
            ),
            backgroundColor: Colors.grey[800],
            iconTheme: const IconThemeData(
              color:  Color.fromRGBO(99, 227, 227, 1), // set the back button color here
            ),
          ),
          body: Container(
            color: const Color.fromRGBO(36, 34, 73, 120),
            child: ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final Movie movie = favoriteMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                          movie: movie,
                          themeData: Theme.of(context),
                          genres: const [],
                          heroId: '${movie.id}-favorites',
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      movie.releaseDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    leading: Flexible(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w185/${movie.posterPath}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
