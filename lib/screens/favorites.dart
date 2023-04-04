// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/movieManager.dart';

class FavoritesPage extends StatelessWidget {
  final List<Movie> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieManager>(
      builder: (context, movieManager, child) {
        final List<Movie> favoriteMovies = movieManager.favorites;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: ListView.builder(
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final Movie movie = favoriteMovies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.releaseDate),
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w185/${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
