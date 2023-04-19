// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:movie_thing/main.dart';
import 'package:movie_thing/screens/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/movie.dart';
import '../models/movieManager.dart';

class FavoritesPage extends StatelessWidget {
  final Map<int, String> genres;

  const FavoritesPage({
    Key? key,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieManager = Provider.of<MovieManager>(context);
    print('Favorite movies from Realtime Database: ${movieManager.favorites}');
    final List<Movie> favoriteMovies = movieManager.favorites;

    if (favoriteMovies.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorites',
            style: TextStyle(
              color: Color.fromRGBO(99, 227, 227, 300),
            ),
          ),
          backgroundColor: Colors.grey[800],
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(
                99, 227, 227, 300), // set the back button color here
          ),
        ),
        body: Container(
          color: const Color.fromRGBO(36, 34, 73, 120),
          child: const Center(
            child: Text(
              'No favorite movies found',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color.fromRGBO(99, 227, 227, 300),
          ),
        ),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(
              99, 227, 227, 300), // set the back button color here
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
              child: IntrinsicHeight(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
