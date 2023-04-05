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
    print('adding ${movie.title}');
    if (!_favorites.contains(movie)) {
      _favorites.add(movie);
      print('not.adding ${movie.title}');
      notifyListeners();
    }
  }

  // Removes a movie from the list of favorite movies and notifies any listeners that the state has changed
  void remove(Movie movie) {
    _favorites.remove(movie);
    notifyListeners();
  }

  // Updates the favorite movie list by adding the new movie and removing the old movie
  void update(Movie oldMovie, Movie newMovie) {
    final index = _favorites.indexOf(oldMovie);
    _favorites[index] = newMovie;
    notifyListeners();
  }

  // Checks if a movie is a favorite by checking if it is in the _favorites list and returns a boolean value
  bool isMovieFavorite(Movie movie) {
    for (Movie current in favorites) {
      if (movie.title == current.title) {
        return true;
      }
    }
    return false;
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
    Movie? found;
    for (Movie current in favorites) {
      if (movie.title == current.title) {
        found = current;
        break;
      }
    }
    if (found != null) {
      remove(found);
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
