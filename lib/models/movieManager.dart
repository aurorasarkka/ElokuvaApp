// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'movie.dart';

class MovieManager extends ChangeNotifier {
  final List<Movie> _favorites;

  MovieManager(List<Movie> favorites) : _favorites = List.from(favorites);

  // Returns the list of favorite movies
  List<Movie> get favorites => _favorites;

  // Adds a movie to the list of favorite movies and notifies any listeners that the state has changed
  void add(Movie movie) {
    _favorites.add(movie);
    notifyListeners();
    print('hello');
  }

  // Removes a movie from the list of favorite movies and notifies any listeners that the state has changed
  void remove(Movie movie) {
    _favorites.remove(movie);
    notifyListeners();
  }

  // Checks if a movie is a favorite by checking if it is in the _favorites list and returns a boolean value
  bool isMovieFavorite(Movie movie) {
    return _favorites.contains(movie);
  }

  // Adds a list of movies to the list of favorite movies and notifies any listeners that the state has changed
  void saveMoviesToFavoriteList(List<Movie> movies) {
    _favorites.addAll(movies);
    notifyListeners();
  }

  // Clears the list of favorite movies and notifies any listeners that the state has changed
  void clearFavoriteList() {
    _favorites.clear();
    notifyListeners();
  }

  void toggleFavorite(Movie movie, BuildContext context) {
    if (_favorites.contains(movie)) {
      remove(movie);
      print('Removed from favorites: ${movie.title}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from favorites: ${movie.title}'),
          duration: const Duration(seconds: 5),
        ),
      );
    } else {
      add(movie);
      print('Added to favorites: ${movie.title}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to favorites: ${movie.title}'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
